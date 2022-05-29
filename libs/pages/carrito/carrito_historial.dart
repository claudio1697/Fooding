

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../base/no_data_page.dart';
import '../../models/carrito_model.dart';
import '../../rutas/rutas_helper.dart';
import '../../utils/app_constants.dart';
import '../../utils/dimensions.dart';
import '../../controller/carrito_controller.dart';
import '../../utils/colors.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/texto_grande.dart';
import 'package:get/get.dart';

import '../../widgets/texto_peque.dart';

class CarritoHistorial extends StatelessWidget {
  const CarritoHistorial({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var getCarritoHistorialLista = Get.find<CarritoController>()
        .getCarritoHistorialLista().reversed.toList();

    Map<String, int> carritoProductosOrden = Map();

    for(int i = 0; i< getCarritoHistorialLista.length;i++){
      if(carritoProductosOrden.containsKey(getCarritoHistorialLista[i].time)){
        carritoProductosOrden.update(getCarritoHistorialLista[i].time!, (value)=>++value);
      }else{
        carritoProductosOrden.putIfAbsent(getCarritoHistorialLista[i].time!,()=>1);
      }
    }
    List<int> carritoProductoPerOrdenToList(){
      return carritoProductosOrden.entries.map((e) =>e.value ).toList();
    }

    List<String> carritoOrdenTiempoToLista(){
      return carritoProductosOrden.entries.map((e)=>e.key).toList();
    }

    List<int> ordenTiempos = carritoProductoPerOrdenToList();

    var listCounter = 0;
    Widget timeWidget(int index){
      var outputDate = DateTime.now().toString();
        if(index<getCarritoHistorialLista.length) {
          DateTime parseDate = DateFormat("yyyy-MM-dd HH:mm:ss").parse(
              getCarritoHistorialLista[listCounter].time!);
          var inputDate = DateTime.parse(parseDate.toString());
          var outPutFormat = DateFormat("MM/dd/yyyy hh:mm a");
          outputDate = outPutFormat.format(inputDate);
        }
        return GranTexto(text: outputDate);
    }
    return Scaffold(

      body: Column(
        children: [
          Container(
            height: Dimension.height10*10,
            color: AppColors.mainColor,
            width: double.maxFinite,
            padding: EdgeInsets.only(top: Dimension.height45,),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GranTexto(text: "Historial Carrito", color: Colors.white,),
                AppIcon(icon: Icons.shopping_cart_outlined,
                  iconColor: AppColors.mainColor,
                  backgroundColor: AppColors.yellowColor,),
              ],
            ),
          ),
         GetBuilder<CarritoController>(builder: (_carritoController){
           var cartLength = _carritoController.getCarritoHistorialLista();
           return cartLength.length>0? Expanded(
               child: Container(

                 margin: EdgeInsets.only(
                   top: Dimension.height20,
                   left: Dimension.width20,
                   right: Dimension.width20,
                 ),
                 child: MediaQuery.removePadding(
                   removeTop: true,
                   context: context,
                   child: ListView(
                     children: [
                       for(int i = 0; i<carritoProductosOrden.length;i++)
                         Container(
                           height: Dimension.height30*4,
                           margin: EdgeInsets.only(bottom: Dimension.height20),
                           child: Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               timeWidget(listCounter),
                               SizedBox(height: Dimension.height10,),
                               Row(
                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                 children: [
                                   Wrap(
                                     direction: Axis.horizontal,
                                     children: List.generate(carritoProductosOrden[i]!, (index){
                                       if(listCounter<getCarritoHistorialLista.length){
                                         listCounter++;
                                       }
                                       return index<=2?Container(
                                         height: Dimension.height20*4,
                                         width: Dimension.height20*4,
                                         margin: EdgeInsets.only(right: Dimension.width10/2),
                                         decoration: BoxDecoration(
                                             borderRadius: BorderRadius.circular(Dimension.radius15/2),
                                             image: DecorationImage(
                                                 fit: BoxFit.cover,
                                                 image: NetworkImage(
                                                   AppConstants.BASE_URL + AppConstants.UPLOAD_URL + getCarritoHistorialLista[listCounter-1].img!,
                                                 ))
                                         ),
                                       ):Container();
                                     }),
                                   ),
                                   Container(

                                     height: Dimension.height20*4,
                                     child: Column(
                                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                       crossAxisAlignment: CrossAxisAlignment.end,
                                       children: [
                                         MiniTexto(text: "Total",color: AppColors.titleColor),
                                         GranTexto(text: carritoProductosOrden[i].toString() + " Productos",
                                           color: AppColors.titleColor,),
                                         GestureDetector(
                                           onTap: (){
                                             //Aqui ponemos las fechas en un mapa y lo ordenamos.
                                             var orderTime = carritoOrdenTiempoToLista();
                                             Map<int,CarritoModel> moreOrder ={};
                                             for(int j = 0; j<getCarritoHistorialLista.length;j++){
                                               if(getCarritoHistorialLista[j].time==orderTime[i]){
                                                 moreOrder.putIfAbsent(getCarritoHistorialLista[j].id!,
                                                         () => CarritoModel.fromJson(jsonDecode(jsonEncode(getCarritoHistorialLista[j])))
                                                 );

                                               }
                                             }
                                             Get.find<CarritoController>().setProductos = moreOrder;
                                             Get.find<CarritoController>().addToCarritoLista();
                                             Get.toNamed(RutaHelper.getCarritoPage());
                                           },
                                           child: Container(
                                             padding: EdgeInsets.symmetric(horizontal: Dimension.width10,
                                                 vertical: Dimension.height10/2),
                                             decoration: BoxDecoration(
                                               borderRadius: BorderRadius.circular(Dimension.radius15/3),
                                               border: Border.all(width: 1,color: AppColors.mainColor),
                                             ),
                                             child: MiniTexto(text: "Uno mas", color: AppColors.mainColor,),
                                           ),
                                         )
                                       ],
                                     ),
                                   )
                                 ],
                               )
                             ],
                           ),

                         ),

                     ],
                   ),),
               )):SizedBox(
             height: MediaQuery.of(context).size.height/1.5,
             child: const Center(
               child: NoDataPage(text: "Aun no has comprado nada",
               imgPath: "assets/image/carrito_vacio.png",),
             ),
           );
         }),
        ],
      ),
    );
  }
}
