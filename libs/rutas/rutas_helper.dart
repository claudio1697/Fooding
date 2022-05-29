import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';

import '../pages/carrito/carrito_page.dart';
import '../pages/comida/popular_comida_detail.dart';
import '../pages/comida/recomendado_comida_detail.dart';
import '../pages/home/home_page.dart';
import '../pages/home/main_homeFooding.dart';
import 'package:get/get.dart';

import '../pages/splash/splash_page.dart';
class RutaHelper{
  static const String splashPage = "/splash-page";
  static const String initial = "/";
  static const String comidaPopular = "/popular-comida";
  static const String comidaRecomendado = "/recomendado-comida";
  static const String carritoPage = "/carrito-page";

  static String getSplashPage()=>'$splashPage';
  static String getInitial()=>'$initial';
  static String getPopularFood(int pageId, String page)=>'$comidaPopular?pageId=$pageId&page=$page';
  static String getRecomendadoFood(int pageId, String page)=>'$comidaRecomendado?pageId=$pageId&page=$page';
  static String getCarritoPage()=>'$carritoPage';

  static List<GetPage> rutas = [
      GetPage(name: splashPage, page: ()=>SplashScreen()),
      GetPage(name: initial , page: ()=>HomePage()),

      GetPage(name: comidaPopular, page: (){
        var pageId = Get.parameters['pageId'];
        var page = Get.parameters['page'];
        return PopularComidaDetail(pageId: int.parse(pageId!), page:page!);
    },
        transition: Transition.fadeIn,
    ),
    GetPage(name: comidaRecomendado, page: (){
      var pageId = Get.parameters['pageId'];
      var page = Get.parameters['page'];
      return RecomendadoComidaDetail(pageId: int.parse(pageId!), page:page!);
    },
      transition: Transition.fadeIn,
    ),
    GetPage(name: carritoPage, page: (){
      return CarritoPage();
    },
      transition: Transition.fadeIn,
    )
  ];
}