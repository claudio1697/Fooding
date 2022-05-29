import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MiniTexto extends StatelessWidget {
  Color? color;
  final String text;
  double size;
  double height;
  MiniTexto({
    Key? key,
    this.color = const Color(0xff090606),
    required this.text,
    this.size = 12,
    this.height = 1.2,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontFamily: 'Roboto', color: color, fontSize: size, height: height),
    );
  }
}
