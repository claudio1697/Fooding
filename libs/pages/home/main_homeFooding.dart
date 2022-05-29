import 'package:flutter/material.dart';


import '../../controller/popular_producto_controller.dart';
import '../../controller/recomendado_producto_controller.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/texto_grande.dart';
import '../../widgets/texto_peque.dart';
import 'food_page_body.dart';
import 'package:get/get.dart';


class MainComidaPage extends StatefulWidget {
  _MainComidaPageState createState() => _MainComidaPageState();
}

class _MainComidaPageState extends State<MainComidaPage> {
  Future<void> _cargarRecursos() async {
    await Get.find<PopularProductoController>().getPopularProductList();
    await Get.find<RecomendadoProductoController>().getRecomendadoProductList();
  }
  @override
  Widget build(BuildContext context) {
    print("altura acutal es " + MediaQuery.of(context).size.height.toString());
    return RefreshIndicator(
        child: Column(children: [
      //Mostrando el header
      Container(
        child: Container(
          margin: EdgeInsets.only(top: 45, bottom: Dimension.height15),
          padding: EdgeInsets.only(left: Dimension.width20, right: Dimension.width20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  GranTexto(text: "ESPAÑA", color: AppColors.mainColor),
                  Row(
                    children: [
                      MiniTexto(
                        text: "Alicante",
                        color: Colors.black54,
                      ),
                      Icon(Icons.arrow_drop_down_rounded)
                    ],
                  )
                ],
              ),
              Center(
                child: Container(
                  width: Dimension.width45,
                  height: Dimension.height45,
                  child: Icon(Icons.search, color: Colors.white, size: Dimension.iconSize24),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimension.radius15),
                    color: AppColors.mainColor,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      //Mostrando el body
      Expanded(
          child: SingleChildScrollView(
            child: FoodPageBody(),
          )),
    ]),
        onRefresh: _cargarRecursos);
  }
}
