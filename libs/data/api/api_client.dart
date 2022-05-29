import 'package:get/get.dart';

import '../../utils/app_constants.dart';

class ApiClient extends GetConnect implements GetxService{

  final String appBaseUrl;
  late Map<String, String> _mainHeaders;
  late String token = AppConstants.TOKEN;

  ApiClient({required this.appBaseUrl}){
    baseUrl = appBaseUrl;
    //Tiempo que tarda en realizarse la peticion, si tarda mas de 30 se para
    timeout = Duration(seconds: 30);
    _mainHeaders = {
      'Content-type' : 'application/json; charset = UTF-8',
      'Authorization' : 'Bearer $token',
    };
  }
  Future<Response> getData(String uri,) async{
    try{
      Response response = await get(uri);
      return response;
    }catch(e){
      return Response(statusCode: 1, statusText: e.toString());
    }
  }
  void updateHeader(String token){
    _mainHeaders = {
      'Content-type' : 'application/json; charset = UTF-8',
      'Authorization' : 'Bearer $token',
    };
  }

  Future <Response> postData(String uri, dynamic body) async {
    try{
    Response response = await post(uri, body, headers: _mainHeaders);
    return response;
    }catch(e){
      print(e.toString());
      return Response(statusCode: 1,statusText: e.toString());
    }
  }
}