// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';

import 'package:food_delivery_app/utills/dimensions.dart';

class CustomButton extends StatelessWidget {
 final VoidCallback? onPressed;
 final String buttonText;
 final bool transparent;
 final EdgeInsets? margin;
 final double? height;
 final double? widht;
 final double? fontSize;
 final double radius;
 final IconData? icon;
 
 
  CustomButton({
    Key? key,
    this.onPressed,
    required this.buttonText,
    required this.transparent,
    this.margin,
    this.height,
    this.widht,
    this.fontSize,
    required this.radius,
    this.icon,
  }) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
