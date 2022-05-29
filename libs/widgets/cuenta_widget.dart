import 'package:flutter/material.dart';

import '../utils/dimensions.dart';
import 'app_icon.dart';
import 'texto_grande.dart';

class CuentaWidget extends StatelessWidget {
  AppIcon appIcon;
  GranTexto granTexto;
   CuentaWidget({Key? key,required this.appIcon, required this.granTexto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(left: Dimension.width20,
      top: Dimension.width10,
      bottom: Dimension.width10
      ),
      child: Row(
        children: [
          appIcon,
          SizedBox(width: Dimension.width20,),
          granTexto,
        ],
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 1,
            offset: Offset(0,2),
            color: Colors.grey.withOpacity(0.2),
          )
        ]
      ),
    );
  }
}
