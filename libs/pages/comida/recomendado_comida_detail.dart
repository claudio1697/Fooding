

import 'package:flutter/material.dart';
import '../../controller/carrito_controller.dart';

import '../../controller/popular_producto_controller.dart';
import '../../controller/recomendado_producto_controller.dart';
import '../../rutas/rutas_helper.dart';
import '../../utils/app_constants.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/expande_texto.dart';
import '../../widgets/texto_grande.dart';
import 'package:get/get.dart';


class RecomendadoComidaDetail extends StatelessWidget {
  final int pageId;
  final String page;
  const RecomendadoComidaDetail({Key? key, required this.pageId, required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var producto = Get.find<RecomendadoProductoController>().recomendadoProductoList[pageId];
    Get.find<PopularProductoController>().initProducto(producto,Get.find<CarritoController>());

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 70,
            title: Row(
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
                    child: AppIcon(icon: Icons.clear),
                ),
                //AppIcon(icon: Icons.shopping_cart_outlined),
                GetBuilder<PopularProductoController>(builder: (controller){
                  return GestureDetector(
                    onTap: (){
                      if(controller.totalProductos>=1)
                        Get.toNamed(RutaHelper.getCarritoPage());
                    },
                    child: Stack(
                      children: [
                        AppIcon(icon: Icons.shopping_cart_outlined,),
                        Get.find<PopularProductoController>().totalProductos>=1?
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
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(20),
              child: Container(

                child: Center(child: GranTexto(size: Dimension.font26, text: producto.name!)),
                width: double.maxFinite,
                padding: EdgeInsets.only(top:5, bottom: 10,),
                decoration: BoxDecoration(
                    color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimension.radius20),
                    topRight: Radius.circular(Dimension.radius20),
                  )
                ),
              ),
            ),
            pinned: true,
            backgroundColor: Colors.green,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                  AppConstants.BASE_URL+AppConstants.UPLOAD_URL+producto.img!,
                width: double.maxFinite,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  child: ExpandeTexto(text: producto.description!),
                  margin: EdgeInsets.only(left: Dimension.width20, right: Dimension.width20),
                ),
              ],
            )
          )
        ],
      ),
      bottomNavigationBar: GetBuilder<PopularProductoController>(builder: (controller){
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.only(
                left: Dimension.width20*2.5,
                right: Dimension.width20*2.5,
                top: Dimension.height10,
                bottom: Dimension.height10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: (){
                        controller.setQuantity(false);
                      },
                      child:  AppIcon(
                          iconSize: Dimension.iconSize24,
                          iconColor: Colors.white,
                          backgroundColor: AppColors.mainColor ,
                          icon: Icons.remove)
                  ),
                  GranTexto(text: "\$ ${producto.price!}  X  ${controller.productoEnCarrito} ", color: AppColors.mainBlackColor, size: Dimension.font26,),
                  GestureDetector(
                      onTap: (){
                        controller.setQuantity(true);
                      },
                      child:  AppIcon(
                          iconSize: Dimension.iconSize24,
                          iconColor: Colors.white,
                          backgroundColor: AppColors.mainColor ,
                          icon: Icons.add)
                  )
                ],
              ),
            ),
            Container(
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
                    child: Icon(
                      Icons.favorite,
                      color: AppColors.mainColor,
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      controller.addProd(producto);
                    },
                    child:  Container(
                      padding: EdgeInsets.only(top: Dimension.height20, bottom: Dimension.height20, left: Dimension.width20, right: Dimension.width20),
                      child: GranTexto(text: "\$ ${producto.price!} | Pal carro", color: Colors.white ,),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimension.radius20),
                        color: AppColors.mainColor,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
