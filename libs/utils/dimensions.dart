import 'package:get/get.dart';

class Dimension {
  static double screenHeight = Get.context!.height;
  static double screenWidth = Get.context!.width;
  static double pageView = screenHeight / 2.64;
  static double pageViewContainer = screenHeight / 3.84;
  static double pageViewTextContainer = screenHeight / 7.03;
  //Altura dinamica
  static double height15 = screenHeight / 56.27;
  static double height10 = screenHeight / 84.4;
  static double height20 = screenHeight / 42.2;
  static double height30 = screenHeight / 28.13;
  static double height45 = screenHeight / 18.76;
  //Anchura dinamica
  static double width15 = screenHeight / 56.27;
  static double width10 = screenHeight / 84.4;
  static double width20 = screenHeight / 42.2;
  static double width30 = screenHeight / 28.13;
  static double width45 = screenHeight / 18.76;
  //Radio dinamico
  static double radius20 = screenHeight / 42.2;
  static double radius15 = screenHeight / 56.27;
  static double radius30 = screenHeight / 28.13;
  //Fuente dinamica
  static double font16 = screenHeight / 52.75;
  static double font20 = screenHeight / 42.2;
  static double font26 = screenHeight / 32.46;
  //Icono dimanico
  static double iconSize24 = screenHeight / 35.17;
  static double iconSize16 = screenHeight / 52.75;
  //Imagen List View Dinamico
  static double listViewImgSize = screenWidth / 3.25;
  static double listViewTextContSize = screenWidth / 3.9;
  //Comida Popular
  static double popularComidaImgSize = screenHeight / 2.41;

  //Splash Screen
  static double splashImg = screenHeight/3.38;

  //Bottom height
  static double bottomHeightBar = screenHeight / 7.03;
}
