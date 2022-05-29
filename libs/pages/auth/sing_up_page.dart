import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../base/show_custom_snackBar.dart';
import '../../controller/auth_controller.dart';
import '../../models/sign_up_body_model.dart';
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
      var authController = Get.find<AuthController>();
      String name = nameController.text.trim();
      String phone = phoneController.text.trim();
      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      if(name.isEmpty){
        ShowCustomSnackBar("Escribe tu nombre", title: "Nombre");
      }else if(phone.isEmpty){
        ShowCustomSnackBar("Escribe tu telefono", title: "Telefono");
      }else if(email.isEmpty){
        ShowCustomSnackBar("Escribe tu email", title: "Email");
      }else if(GetUtils.isEmail(email)){
        ShowCustomSnackBar("Escribe email valido", title: "Email Valido");
      }else if(password.isEmpty){
        ShowCustomSnackBar("Escribe tu contraseña", title: "Contraseña");
      }else if(password.length<6){
        ShowCustomSnackBar("Escribe no puedes ser menos que 6", title: "Contraseña");
      }else{
        SignUpBody signUpBody = SignUpBody(name: name,
            phone: phone,
            email: email,
            password: password);
        authController.registration(signUpBody).then((status){
          if(status.isSuccess){
              print("Te has registrado");
          }else{
            ShowCustomSnackBar(status.message);
          }
        });
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
                _registration();
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
