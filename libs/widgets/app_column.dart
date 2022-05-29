import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/dimensions.dart';
import 'icon_and_text_widget.dart';
import 'texto_grande.dart';
import 'texto_peque.dart';

class AppColumn extends StatelessWidget {
  final String text;
  const AppColumn({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GranTexto(text: text, size: Dimension.font26,),
        SizedBox(
          height: Dimension.height10,
        ),
        Row(
          children: [
            Wrap(
              children: List.generate(5, (index) {
                return Icon(
                  Icons.star,
                  color: AppColors.mainColor,
                  size: 15,
                );
              }),
            ),
            SizedBox(width: 10),
            MiniTexto(text: "4.5"),
            SizedBox(width: 10),
            MiniTexto(text: "1287"),
            SizedBox(width: 10),
            MiniTexto(text: "comments"),
          ],
        ),
        SizedBox(height: Dimension.height20),
        Row(
          children: [
            IconAndTextWidget(icon: Icons.circle_sharp,
                text: "Normal",
                iconColor: AppColors.iconColor1),
            IconAndTextWidget(icon: Icons.location_on,
                text: "1.7km",
                iconColor: AppColors.mainColor),
            IconAndTextWidget(icon: Icons.access_time_rounded,
                text: "32min",
                iconColor: AppColors.iconColor1),
          ],
        ),
      ],
    );
  }
}
