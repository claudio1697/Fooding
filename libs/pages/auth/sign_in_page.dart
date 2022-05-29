import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/app_text_field.dart';
import '../../widgets/texto_grande.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(height: Dimension.screenHeight*0.05,),
            //App logo
            Container(
              height: Dimension.screenHeight*0.25,
              child: Center(
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 80,
                  backgroundImage: AssetImage(
                      "assets/image/Logo.png"
                  ),
                ),
              ),
            ),
            //bienvenido
            Container(
              margin:EdgeInsets.only(left: Dimension.width20),
              width: double.maxFinite,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "COMIDA",
                    style: TextStyle(
                      fontSize: Dimension.font20*3+Dimension.font20/2,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                    Text(
                        "Sign in tu cuenta",
                        style: TextStyle(
                        fontSize: Dimension.font20,
                          //fontWeight: FontWeight.bold,
                          color:Colors.grey[500],
                      ),
                    ),
                ],
              ),
            ),
            SizedBox(height: Dimension.height20,),
            //email
            AppTextField(
                textEditingController: emailController,
                hintText: "Email", iconData: Icons.email),
            SizedBox(height: Dimension.height20,),
            //paswword
            AppTextField(
                textEditingController: passwordController,
                hintText: "Contraseña", iconData: Icons.password_sharp),
            SizedBox(height: Dimension.height10,),
            //linea tag
            Row(
              children: [
                Expanded(child: Container()),
                RichText(
                  text: TextSpan(
                    text: "Sign in tu cuenta",
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: Dimension.font16,
                    ),
                  ),
                ),
                SizedBox(width: Dimension.width20,),
              ],
            ),
            SizedBox(height: Dimension.screenHeight*0.05,),
            //Sign in
            Container(
              width: Dimension.screenWidth/2,
              height: Dimension.screenHeight/13,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimension.radius30),
                color: AppColors.mainColor,
              ),
              child: Center(
                child: GranTexto(
                  text: "Sign In",
                  size: Dimension.font20+Dimension.font20/2,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: Dimension.screenHeight*0.05,),
            RichText(
              text: TextSpan(
                text: "¿No tienes cuenta?",
                style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: Dimension.font20,
                ),
                children: [
                  TextSpan(
                    recognizer: TapGestureRecognizer()..onTap=()=>Get.to(()=>SignInPage(),
                        transition: Transition.fade),
                  text: "Crea una",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.mainBlackColor,
                    fontSize: Dimension.font20,
                  ))
                ]
              ),
            ),


          ],
        ),
      ),
    );
  }
}
