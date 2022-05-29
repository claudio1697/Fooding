import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/app_text_field.dart';
import '../../widgets/texto_grande.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();
    var signUpImages =[
      "t.png",
      "f.png",
      "g.png",
    ];
    void _registration(){
      String name = nameController.text.trim();
      String phone = phoneController.text.trim();
      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      if(name.isEmpty){

      }else if(phone.isEmpty){

      }else if(email.isEmpty){

      }else if(GetUtils.isEmail(email)){

      }else if(password.isEmpty){

      }else if(password.length<6){

      }else{

      }
    }
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
            //email
            AppTextField(
                textEditingController: emailController,
                hintText: "Email", iconData: Icons.email),
            SizedBox(height: Dimension.height20,),
            //paswword
            AppTextField(
                textEditingController: passwordController,
                hintText: "Contraseña", iconData: Icons.password_sharp),
            SizedBox(height: Dimension.height20,),
            //Nombre
            AppTextField(
                textEditingController: nameController,
                hintText: "Nombre", iconData: Icons.person),
            SizedBox(height: Dimension.height20,),
            //Telefono
            AppTextField(
                textEditingController: phoneController,
                hintText: "Telefono", iconData: Icons.phone),
            SizedBox(height: Dimension.height20,),
            //boton SignUP
            GestureDetector(
              onTap: (){

              },
              child: Container(
                width: Dimension.screenWidth/2,
                height: Dimension.screenHeight/13,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimension.radius30),
                  color: AppColors.mainColor,
                ),
                child: Center(
                  child: GranTexto(
                    text: "Sign Up",
                    size: Dimension.font20+Dimension.font20/2,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: Dimension.height10,),
            //linea tag
            RichText(
                text: TextSpan(
                  recognizer: TapGestureRecognizer()..onTap=()=>Get.back(),
                  text: "¿Tienes ya cuenta?",
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: Dimension.font16,
                  ),
                ),
            ),
            SizedBox(height: Dimension.screenHeight*0.05,),
            RichText(
              text: TextSpan(
                text: "O sino usa uno de estos metodos",
                style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: Dimension.font16,
                ),
              ),
            ),
            Wrap(
              children: List.generate(3, (index) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  radius: Dimension.radius30,
                  backgroundImage: AssetImage(
                    "assets/image/"+signUpImages[index]
                  ),
                ),
              )),
            ),
          ],
        ),
      ),
    );


  }
}
