import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller/carrito_controller.dart';
import 'controller/popular_producto_controller.dart';
import 'controller/recomendado_producto_controller.dart';
import 'pages/carrito/carrito_page.dart';
import 'pages/comida/recomendado_comida_detail.dart';
import 'helper/dependency.dart' as dep;
import 'pages/home/food_page_body.dart';
import 'pages/home/main_homeFooding.dart';
import 'rutas/rutas_helper.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(MyApp());
}

 class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.find<CarritoController>().getCarritoData();
  //Pues que se me borraba tras ejecutar la animacion de splasScreen,
    //Y esta es la solucion que he encontrado, un return de un return de un return
    //que usa un GetBuilder de GetX y que coge las classes de controller y las
    //mantiene sin borrarlas
  return GetBuilder<PopularProductoController>(builder: (_){
     return GetBuilder<RecomendadoProductoController>(builder: (_){
       return GetMaterialApp(
         debugShowCheckedModeBanner: false,
         title: 'Fooding',
         //home: MainComidaPage(),
         initialRoute: RutaHelper.getSplashPage(),
         getPages: RutaHelper.rutas,
       );
     });
   });
  }
}
