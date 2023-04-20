// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:food_delivery_app/utills/dimensions.dart';

class AppIcon extends StatelessWidget {
  final Color backgroundColor;
  final Color iconColor;
  final double iconSize;
  final IconData icon;
  final double newSize;

  const AppIcon({
    Key? key,
    this.backgroundColor = const Color(0xfffcf4e4),
    this.iconColor = const Color(0xff756d54),
    this.iconSize = 40,
    required this.icon,
     this.newSize = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: iconSize,
      height: iconSize,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(iconSize / 2),
        color: backgroundColor,
      ),
      child: Icon(
        icon,
        color: iconColor,
        size: newSize == 0 ? Dimensions.iconSize16 : newSize
      ),
    );
  }
}
