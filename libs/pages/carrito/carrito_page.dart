


import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../base/no_data_page.dart';
import '../../controller/carrito_controller.dart';
import '../../controller/popular_producto_controller.dart';
import '../../controller/recomendado_producto_controller.dart';
import '../../rutas/rutas_helper.dart';
import '../../utils/app_constants.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/app_icon.dart';


import '../../widgets/texto_grande.dart';
import '../../widgets/texto_peque.dart';

class CarritoPage extends StatelessWidget {
  const CarritoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          //Seccion Iconos
          Positioned(
            top: Dimension.height20*3,
            left: Dimension.width20,
              right: Dimension.width20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppIcon(icon: Icons.arrow_back_ios,
                  iconColor: Colors.white,
                  backgroundColor: AppColors.mainColor,
                  iconSize: Dimension.iconSize24,
                  ),
                  SizedBox(width: Dimension.width20*5,),
                  GestureDetector(
                    onTap: (){
                      Get.toNamed(RutaHelper.getInitial());
                    },
                    child: AppIcon(icon: Icons.home_outlined,
                      iconColor: Colors.white,
                      backgroundColor: AppColors.mainColor,
                      iconSize: Dimension.iconSize24,
                    ),
                  ),
                  AppIcon(icon: Icons.shopping_cart,
                    iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                    iconSize: Dimension.iconSize24,
                  ),
                ],
          )),
          GetBuilder<CarritoController>(builder: (_cartController){
            return _cartController.getProductos.length>0?Positioned(
                top: Dimension.height20*5,
                left: Dimension.width20,
                right: Dimension.width20,
                bottom: 0,
                child: Container(
                  margin: EdgeInsets.only(top: Dimension.height15),
                  //color: Colors.black,
                  child: MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: GetBuilder<CarritoController>(builder: (carritoController){
                      var _carritoLista = carritoController.getProductos;
                      return ListView.builder(
                          itemCount:_carritoLista.length,
                          itemBuilder: (_,index){
                            return Container(
                              width: double.maxFinite,
                              height: Dimension.height20*5,
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: (){
                                      var popularIndex = Get.find<PopularProductoController>()
                                          .popularProductoList
                                          .indexOf(_carritoLista[index].productModel!);
                                      if(popularIndex>=0){
                                        Get.toNamed(RutaHelper.getPopularFood(popularIndex,"cartpage"));
                                      }else{
                                        var recomendadoIndex = Get.find<RecomendadoProductoController>()
                                            .recomendadoProductoList
                                            .indexOf(_carritoLista[index].productModel!);
                                        if(recomendadoIndex<0){
                                          Get.snackbar("Historial de Productos", "Este producto no se puede revisar aun",
                                            backgroundColor: AppColors.mainColor,
                                            colorText: Colors.white,
                                          );
                                        }else{
                                          Get.toNamed(RutaHelper.getRecomendadoFood(recomendadoIndex, "cartpage"));
                                        }
                                      }
                                    },
                                    child: Container(
                                      width: Dimension.height20*5,
                                      height: Dimension.height20*5,
                                      margin: EdgeInsets.only(bottom: Dimension.height10),
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                                AppConstants.BASE_URL + AppConstants.UPLOAD_URL + carritoController.getProductos[index].img!
                                            )
                                        ),
                                        borderRadius: BorderRadius.circular(
                                            Dimension.radius20
                                        ),
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: Dimension.width10,),
                                  Expanded(
                                      child: Container(
                                        height: Dimension.height20*5,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            GranTexto(text: carritoController.getProductos[index].name!, color: Colors.white,),
                                            MiniTexto(text: "Picante",),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                GranTexto(text: carritoController.getProductos[index].price.toString(), color: Colors.redAccent,),
                                                Container(
                                                  padding: EdgeInsets.only(top: Dimension.height10, bottom: Dimension.height10, left: Dimension.width10, right: Dimension.width10),
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(Dimension.radius20),
                                                    color: Colors.white,
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      GestureDetector(
                                                          onTap: (){
                                                            carritoController.addProd(_carritoLista[index].productModel!, -1);
                                                          },
                                                          child: Icon(Icons.remove, color: AppColors.signColor,)),
                                                      SizedBox(width: Dimension.width10/2,),
                                                      GranTexto(text: _carritoLista[index].quantity.toString()),//popularProducto.productoEnCarrito.toString()),
                                                      SizedBox(width: Dimension.width10/2,),
                                                      GestureDetector(
                                                          onTap: (){
                                                            carritoController.addProd(_carritoLista[index].productModel!, 1);
                                                          },
                                                          child: Icon(Icons.add, color: AppColors.signColor,)),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],

                                        ),
                                      ))
                                ],
                              ),
                            );
                          });
                    }),
                  ),
                )):
              NoDataPage(text: "Tu carrito esta vacio!");
          }),
        ],
      ),
        bottomNavigationBar: GetBuilder<CarritoController>(builder: (carritoController){
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
            child: carritoController.getProductos.length>0?Row(
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

                    SizedBox(width: Dimension.width10/2,),
                    GranTexto(text: "\$ " + carritoController.cantidadTotal.toString()),
                    SizedBox(width: Dimension.width10/2,),

                  ],
                ),
              ),
              GestureDetector(
                onTap: (){
                  //popularProducto.addProd(producto);
                  carritoController.addToHistorial();
                },
                child: Container(
                  padding: EdgeInsets.only(top: Dimension.height20, bottom: Dimension.height20, left: Dimension.width20, right: Dimension.width20),
                  child: GranTexto(text: "Pagar", color: Colors.white ,),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimension.radius20),
                    color: AppColors.mainColor,
                  ),
                ),
              )
            ],
          ):Container(),
          );
        },)
    );
  }
}
