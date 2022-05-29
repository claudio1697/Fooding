import 'package:get/get.dart';
import '../../utils/app_constants.dart';

import '../api/api_client.dart';

class RecomendadoProductoRepo extends GetxService{
  final ApiClient apiClient;
  RecomendadoProductoRepo({required this.apiClient});

  Future<Response> getRecomendadoProductoList() async{
    return await apiClient.getData(AppConstants.RECOMENDADO_PRODUCTO_URI);
  }
}