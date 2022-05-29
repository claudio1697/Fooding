import 'dart:async';
import '../../utils/dimensions.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/popular_producto_controller.dart';
import '../../controller/recomendado_producto_controller.dart';
import '../../rutas/rutas_helper.dart';
import '../../widgets/texto_grande.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{

  late Animation<double> animation;
  late AnimationController animationController;

  Future<void> _cargarRecursos() async {
     await Get.find<PopularProductoController>().getPopularProductList();
     await Get.find<RecomendadoProductoController>().getRecomendadoProductList();
  }

  @override
  void initState(){

    /*
    * clase(){
    *       newObject(){
    *     return..
    *   }
    * }
    * asi:
    * var x = clase()..newObject()
    * o sino:
    * x = x.newObject()
    * */

    super.initState();
    _cargarRecursos();
    animationController =  AnimationController(vsync: this,
        duration: const Duration(seconds: 2))..forward();
    animation =  CurvedAnimation(
        parent: animationController,
        curve: Curves.linear);
    Timer(
      Duration(seconds: 3),
        ()=>Get.offNamed(RutaHelper.getInitial())
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(
            scale: animation,
              child: Center(
            child: Image.asset("assets/image/Logo.png",
              width: Dimension.splashImg,),
          )),
        ],
      ),
    );
  }
}
