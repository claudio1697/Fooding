import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/dimensions.dart';
import 'texto_peque.dart';

class ExpandeTexto extends StatefulWidget {
  final String text;
  const ExpandeTexto({Key? key, required this.text}) : super(key: key);

  @override
  State<ExpandeTexto> createState() => _ExpandeTextoState();
}

class _ExpandeTextoState extends State<ExpandeTexto> {
  late String first;
  late String second;

  bool hiddenText = true;

  double textHeight = Dimension.screenHeight/5.63;

  @override
  void initState(){
    super.initState();
    if(widget.text.length>textHeight){
      first = widget.text.substring(0, textHeight.toInt());
      //Comprobamos el tamaño del texto y si es mayor se oculta.
      second = widget.text.substring(textHeight.toInt()+1, widget.text.length);
    }else{
      first = widget.text;
      second = "";
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      //Si la segunda parte del texto esta vacio se coge la primera parte, sino vamos a una Columna
      //y ahi pues se hace lo que expande el texto
      child: second.isEmpty?MiniTexto(size: Dimension.font16,text: first):Column(
        children: [
          //Aqui se muestra segun el booleano
          MiniTexto(height: 1.6 ,size: Dimension.font16,text: hiddenText?(first+"..."):(first + second)),
          InkWell(
            onTap: (){
              setState((){
                hiddenText =! hiddenText;
              });
            },
            child: Row(
              children: [
                MiniTexto(size: Dimension.font16 ,text: "Mostrar mas", color: AppColors.paraColor,),
                Icon(hiddenText?Icons.arrow_drop_down:Icons.arrow_drop_up, color: AppColors.mainColor,),
              ],
            ),
          )
        ],
      ),
    );
  }
}
