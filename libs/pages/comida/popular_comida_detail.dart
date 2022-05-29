

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/carrito_controller.dart';
import '../../controller/popular_producto_controller.dart';
import '../../rutas/rutas_helper.dart';
import '../../utils/app_constants.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/app_column.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/expande_texto.dart';
import '../../widgets/texto_grande.dart';
import '../home/main_homeFooding.dart';

class PopularComidaDetail extends StatelessWidget {
  final int pageId;
  final String page;
  const PopularComidaDetail({Key? key, required this.pageId, required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var producto = Get.find<PopularProductoController>().popularProductoList[pageId];
    Get.find<PopularProductoController>().initProducto(producto,Get.find<CarritoController>());

    return Scaffold(
        backgroundColor: Colors.black,
      body: Stack(
        children: [
          //Seccion Imagen de fondo
          Positioned(
              left: 0,
              right: 0,
              child: Container(
                width: double.maxFinite,
                height: Dimension.popularComidaImgSize,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      AppConstants.BASE_URL+AppConstants.UPLOAD_URL+producto.img!
                    )
                  )
                ),
          )),
          //Seccion iconos de carrito y vuelta
          Positioned(
            top: Dimension.height45,
            left: Dimension.width20,
            right: Dimension.width20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: (){
                        if(page=='cartpage'){
                          Get.toNamed(RutaHelper.getCarritoPage());
                        }else{
                          Get.toNamed(RutaHelper.getInitial());
                        }
                      },
                      child: AppIcon(icon: Icons.arrow_back_ios)),

                 GetBuilder<PopularProductoController>(builder: (controller){
                   return GestureDetector(
                     onTap: (){
                       if(controller.totalProductos>=1)
                       Get.toNamed(RutaHelper.getCarritoPage());
                     },
                     child: Stack(
                         children: [
                         AppIcon(icon: Icons.shopping_cart_outlined,),
                           controller.totalProductos>=1?
                              Positioned(
                                right: 0, top: 0,

                                  child: AppIcon(icon: Icons.circle, size: 20,
                                    iconColor: Colors.transparent,
                                    backgroundColor: AppColors.mainColor,),

                              ):
                                  Container(),
                           Get.find<PopularProductoController>().totalProductos>=1?
                           Positioned(
                             right: 3, top: 3,
                             child: GranTexto(text:Get.find<PopularProductoController>().totalProductos.toString(),
                             size: 12, color: Colors.white,
                             ),
                           ):
                           Container(),

                         ],
                     ),
                   );
                 })
                ],
          )),
          //Introduccion a la comida
          Positioned(
             left: 0,
              right: 0,
              bottom: 0,
              top: Dimension.popularComidaImgSize-20,
              child: Container(
              padding: EdgeInsets.only(left: Dimension.width20, right: Dimension.width20, top: Dimension.height20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(Dimension.radius20),
                    topLeft: Radius.circular(Dimension.radius20)
                  ),
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppColumn(text: producto.name! ),
                    SizedBox(height: Dimension.height20,),
                    GranTexto(text: "Presentamos"),
                    SizedBox(height: Dimension.height20,),
                    Expanded(
                      child: SingleChildScrollView(
                        child: ExpandeTexto(text: producto.description!),
                      ),
                    )
                  ],
                ),

          )),
        ],
      ),
      bottomNavigationBar: GetBuilder<PopularProductoController>(builder: (popularProducto){
        return Container(
          height: Dimension.bottomHeightBar,
          padding: EdgeInsets.only(top: Dimension.height30, bottom: Dimension.height30, left: Dimension.width20, right: Dimension.width20),
          decoration: BoxDecoration(
              color: AppColors.buttonBackgroundColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Dimension.radius20*2),
                topRight: Radius.circular(Dimension.radius20*2),
              )
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.only(top: Dimension.height20, bottom: Dimension.height20, left: Dimension.width20, right: Dimension.width20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimension.radius20),
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    GestureDetector(
                        onTap: (){
                          popularProducto.setQuantity(false);
                        },
                        child: Icon(Icons.remove, color: AppColors.signColor,)),
                    SizedBox(width: Dimension.width10/2,),
                    GranTexto(text: popularProducto.productoEnCarrito.toString()),
                    SizedBox(width: Dimension.width10/2,),
                    GestureDetector(
                        onTap: (){
                          popularProducto.setQuantity(true);
                        },
                        child: Icon(Icons.add, color: AppColors.signColor,)),
                  ],
                ),
              ),
              GestureDetector(
                onTap: (){
                  popularProducto.addProd(producto);
                },
                child: Container(
                  padding: EdgeInsets.only(top: Dimension.height20, bottom: Dimension.height20, left: Dimension.width20, right: Dimension.width20),
                      child: GranTexto(text: "\$ ${producto.price!} "+" Pal carro", color: Colors.white ,),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimension.radius20),
                    color: AppColors.mainColor,
                  ),
                ),
              )
            ],
          ),
        );
      },),
    );
  }
}
