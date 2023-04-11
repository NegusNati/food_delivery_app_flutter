// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:food_delivery_app/widgets/small_text.dart';

import '../utills/colors.dart';
import '../utills/dimensions.dart';
import 'big_text.dart';
import 'icon_widget.dart';

class InfoColumn extends StatelessWidget {
  final String text;
  final double size;
  const InfoColumn({
    Key? key,
    required this.text,
    this.size = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      BigText(text: text, size: size),
      SizedBox(
        height: Dimensions.Height5,
      ),
      Row(children: [
        Wrap(
          children: List.generate(
            5,
            (index) => Icon(Icons.star, color: AppColors.mainColor, size:  Dimensions.Height5),
          ),
        ),
         SizedBox(width: Dimensions.Width5),
        SmallText(text: "4.5"),
         SizedBox(width: Dimensions.Width5),
        SmallText(text: "1234"),
         SizedBox(width: Dimensions.Width5),
        SmallText(text: "comments"),
      ]),
      SizedBox(height: Dimensions.Height20),
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        IconWidget(
            icon: Icons.circle_sharp,
            text: "Normal",
            iconColor: AppColors.iconColor1),
        IconWidget(
            icon: Icons.location_on,
            text: "1.7km",
            iconColor: AppColors.mainColor),
        IconWidget(
            icon: Icons.access_time_rounded,
            text: "32min",
            iconColor: AppColors.iconColor2),
      ])
    ]);
  }
}
