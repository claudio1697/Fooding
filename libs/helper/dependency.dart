import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../controller/auth_controller.dart';
import '../controller/carrito_controller.dart';

import '../controller/popular_producto_controller.dart';
import '../controller/recomendado_producto_controller.dart';
import '../data/api/api_client.dart';
import '../data/repository/auth_repo.dart';
import '../data/repository/carrito_repo.dart';
import '../data/repository/producto_popular_repo.dart';
import '../data/repository/producto_recomendado_repo.dart';
import '../utils/app_constants.dart';

Future<void> init()async {
  final sharedPreferences = await SharedPreferences.getInstance();

  Get.lazyPut(() => sharedPreferences);
  //ApiClient
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.BASE_URL));
  Get.lazyPut(() => AuthRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  //Repos
  Get.lazyPut(() => PopularProductoRepo(apiClient: Get.find()));
  Get.lazyPut(() => RecomendadoProductoRepo(apiClient: Get.find()));
  Get.lazyPut(() => CarritoRepo(sharedPreferences: Get.find()));
  //Controllers
  Get.lazyPut(() => AuthController(authRepo: Get.find()));
  Get.lazyPut(() => PopularProductoController(popularProductoRepo: Get.find()));
  Get.lazyPut(() => RecomendadoProductoController(recomendadoProductoRepo: Get.find()));
  Get.lazyPut(() => CarritoController(carritoRepo: Get.find()));
}