import 'package:get/get.dart';
import '../../utils/app_constants.dart';

import '../api/api_client.dart';

class PopularProductoRepo extends GetxService{
  final ApiClient apiClient;
  PopularProductoRepo({required this.apiClient});

  Future<Response> getPopularProductoList() async{
    return await apiClient.getData(AppConstants.POPULAR_PRODUCTO_URI);
  }
}