import 'package:flutter/material.dart';

import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/cuenta_widget.dart';
import '../../widgets/texto_grande.dart';

class CuentaPage extends StatelessWidget {
  const CuentaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: GranTexto(
          text: "Perfil", size: 24, color: Colors.white,
        ),
      ),
      body: Container(
        width: double.maxFinite,
        margin: EdgeInsets.only(top: Dimension.height20),
        child: Column(

          children: [
            //Icono Perfil
            AppIcon(icon: Icons.person,
            backgroundColor: AppColors.mainColor,
            iconColor: Colors.white,
              iconSize: Dimension.height45 + Dimension.height30,
              size: Dimension.height15*10,
            ),
            SizedBox(height: Dimension.height30,),
            Expanded(
                child: SingleChildScrollView(
                     child: Column(
                        children: [
                          //Nombre
                          CuentaWidget(
                            appIcon: AppIcon(icon: Icons.person,
                              backgroundColor: AppColors.mainColor,
                              iconColor: Colors.white,
                              iconSize:Dimension.height10*5/2 ,
                              size: Dimension.height10*5,),
                            granTexto: GranTexto(text: "Claudio"),
                          ),
                          SizedBox(height: Dimension.height20,),
                          //Telefono
                          CuentaWidget(
                            appIcon: AppIcon(icon: Icons.phone,
                              backgroundColor: AppColors.yellowColor,
                              iconColor: Colors.white,
                              iconSize:Dimension.height10*5/2 ,
                              size: Dimension.height10*5,),
                            granTexto: GranTexto(text: "6969696969"),
                          ),
                          SizedBox(height: Dimension.height20,),
                          //Email
                          CuentaWidget(
                            appIcon: AppIcon(icon: Icons.email,
                              backgroundColor: AppColors.yellowColor,
                              iconColor: Colors.white,
                              iconSize:Dimension.height10*5/2 ,
                              size: Dimension.height10*5,),
                            granTexto: GranTexto(text: "claudiu.florin.oneat@gmail.com"),
                          ),
                          SizedBox(height: Dimension.height20,),
                          //Direccion
                          CuentaWidget(
                            appIcon: AppIcon(icon: Icons.location_on,
                              backgroundColor: AppColors.yellowColor,
                              iconColor: Colors.white,
                              iconSize:Dimension.height10*5/2 ,
                              size: Dimension.height10*5,),
                            granTexto: GranTexto(text: "Pont tu direccion"),
                          ),
                          SizedBox(height: Dimension.height20,),
                          //Mensaje
                          CuentaWidget(
                            appIcon: AppIcon(icon: Icons.message_outlined,
                              backgroundColor: Colors.redAccent,
                              iconColor: Colors.white,
                              iconSize:Dimension.height10*5/2 ,
                              size: Dimension.height10*5,),
                            granTexto: GranTexto(text: "Pont tu direccion"),
                          ),
                          SizedBox(height: Dimension.height20,),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}
