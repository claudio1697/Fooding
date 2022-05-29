
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/texto_grande.dart';


void ShowCustomSnackBar(String message, {bool isError=true, String title="Error"}){
    Get.snackbar(title, message,
    titleText: GranTexto(text: title, color: Colors.white,),
      messageText: Text(message, style: TextStyle(
        color: Colors.white,
      ),

      ),
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.redAccent,
    );
}