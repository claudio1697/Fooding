
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/sign_up_body_model.dart';
import '../../utils/app_constants.dart';
import '../api/api_client.dart';


class AuthRepo{
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  AuthRepo({
    required this.apiClient,
    required this.sharedPreferences
  });
  
 Future<Response> registration(SignUpBody signUpBody) async{
    return await apiClient.postData(AppConstants.REGISTRATION_URI, signUpBody);
  }

  saveUserToken(String token){
   apiClient.token = token;
   apiClient.updateHeader(token);
  }
  
}