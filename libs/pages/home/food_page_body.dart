import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/popular_producto_controller.dart';
import '../../controller/recomendado_producto_controller.dart';
import '../../models/product_model.dart';
import '../../rutas/rutas_helper.dart';
import '../../utils/app_constants.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/app_column.dart';
import '../../widgets/icon_and_text_widget.dart';
import '../../widgets/texto_grande.dart';
import '../../widgets/texto_peque.dart';
import '../comida/popular_comida_detail.dart';


class FoodPageBody extends StatefulWidget {
  const FoodPageBody({Key? key}) : super(key: key);
  _FoodPageBodyState createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController = PageController(viewportFraction: 0.85);
  var _currPageValue = 0.0;
  double _scaleFactor = 0.8;
  double _height = Dimension.pageViewContainer;
  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currPageValue = pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //Seccion del Slider
        GetBuilder<PopularProductoController>(builder:(popularProducts){
          return popularProducts.cargando?Container(
            // color: Colors.red,
              height: Dimension.pageView,

                child: PageView.builder(
                    controller: pageController,
                    itemCount: popularProducts.popularProductoList.length,
                    itemBuilder: (context, position) {
                      return _buildPageItem(position, popularProducts.popularProductoList[position]);
                    }),

          ):CircularProgressIndicator(
            color: AppColors.mainColor,
          );
        }),
        //Seccion puntitos
        GetBuilder<PopularProductoController>(builder: (popularProducts){
          return DotsIndicator(
            dotsCount: popularProducts.popularProductoList.isEmpty?1:popularProducts.popularProductoList.length,
            position: _currPageValue,
            decorator: DotsDecorator(
              size: const Size.square(9.0),
              activeSize: const Size(18.0, 9.0),
              activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
            ),
          );
        }),

        //Seccion Popular
        SizedBox(
          height: Dimension.height30,
        ),
        Container(
          margin: EdgeInsets.only(left: Dimension.width30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              GranTexto(text: "Recomendado"),
              SizedBox(
                width: Dimension.width10,
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 3),
                child: GranTexto(text: ".", color: Colors.black26),
              ),
              SizedBox(
                width: Dimension.width10,
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 2),
                child: MiniTexto(
                  text: "COMIDA PODEROSA",
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: Dimension.height20,
        ),
        //Lista de Comida Recomendada
          GetBuilder<RecomendadoProductoController>(builder: (recomendadoProducto){
            return recomendadoProducto.cargando?ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: recomendadoProducto.recomendadoProductoList.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: (){
                      Get.toNamed(RutaHelper.getRecomendadoFood(index, "home"));
                    },
                    child: Container(
                        margin: EdgeInsets.only(left: Dimension.width20, right: Dimension.width20, bottom: Dimension.height10),
                        child: Row(
                          children: [
                            //Seccion de Imagenes
                            Container(
                              width: Dimension.listViewImgSize,
                              height: Dimension.listViewImgSize,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(Dimension.radius20),
                                color: Colors.white38,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(AppConstants.BASE_URL + AppConstants.UPLOAD_URL + recomendadoProducto.recomendadoProductoList[index].img!),
                                ),
                              ),
                            ),
                            //Seccion de Texto
                            Expanded(
                              child: Container(
                                height: Dimension.listViewTextContSize,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(Dimension.radius20),
                                    bottomRight: Radius.circular(Dimension.radius20),
                                  ),
                                  color: Colors.white,
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(left: Dimension.width10, right: Dimension.width10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GranTexto(text: recomendadoProducto.recomendadoProductoList[index].name!),
                                      SizedBox(
                                        height: Dimension.height10,
                                      ),
                                      MiniTexto(text: "Tiene Chocolate"),
                                      SizedBox(
                                        height: Dimension.height10,
                                      ),
                                      Row(
                                        children: [
                                          IconAndTextWidget(icon: Icons.circle_sharp, text: "Normal", iconColor: AppColors.iconColor1),
                                          IconAndTextWidget(icon: Icons.location_on, text: "1.7km", iconColor: AppColors.mainColor),
                                          IconAndTextWidget(icon: Icons.access_time_rounded, text: "32min", iconColor: AppColors.iconColor1),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )),
                  );
                }):CircularProgressIndicator(
              color: AppColors.mainColor,
            );
          }),

      ],
    );
  }

  Widget _buildPageItem(int index,ProductModel popularProducto) {
    Matrix4 matrix = new Matrix4.identity();
    if (index == _currPageValue.floor()) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() + 1) {
      var currScale = _scaleFactor + (_currPageValue - index + 1) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() - 1) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, _height * (1 - _scaleFactor) / 2, 1);
    }
    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          GestureDetector(
          onTap: (){
            Get.toNamed(RutaHelper.getPopularFood(index, "home"));
            },
            child: Container(
              height: Dimension.pageViewContainer,
              margin: EdgeInsets.only(left: Dimension.width10, right: Dimension.width10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimension.radius30),
                color: index.isEven ? Color(0xFF69c5df) : Color(0xFF9294cc),
                image: DecorationImage(fit: BoxFit.cover, image: NetworkImage(AppConstants.BASE_URL + AppConstants.UPLOAD_URL + popularProducto.img!)),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Dimension.pageViewTextContainer,
              margin: EdgeInsets.only(left: Dimension.width30, right: Dimension.width30, bottom: Dimension.height30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimension.radius20),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFFe8e8e8),
                    blurRadius: 5.0,
                    offset: Offset(0, 5),
                  ),
                  BoxShadow(
                    color: Colors.white,
                    offset: Offset(-5, 0),
                  ),
                  BoxShadow(
                    color: Colors.white,
                    offset: Offset(5, 0),
                  ),
                ],
              ),
              child: Container(
                padding: EdgeInsets.only(top: Dimension.height15, left: Dimension.height15, right: Dimension.height15),
                child: AppColumn(text:popularProducto.name!),
              ),
            ),
          )
        ],
      ),
    );
  }
}
