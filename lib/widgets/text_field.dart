// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:food_delivery_app/utills/dimensions.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController textController;
  final String hintText;
  IconData icon;
  final Color? color;

  TextFieldWidget({
    Key? key,
    required this.textController,
    required this.hintText,
    required this.icon,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          top: Dimensions.Height20,
          left: Dimensions.Width20,
          right: Dimensions.Width20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(Dimensions.radiusSize20),
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              spreadRadius: 7,
              offset: const Offset(1, 10),
              color: Colors.grey.withOpacity(0.2),
            )
          ]),
      child: TextField(
        controller: textController,
        decoration: InputDecoration(
          // contentPadding: EdgeInsets.only(left: Dimensions.Width10),
          hintText: hintText,
          hintStyle: TextStyle(
            fontWeight: FontWeight.w300,
            fontSize: Dimensions.fontSize20,
          ),
          prefixIcon: Icon(
            icon,
            color: color,
            size: Dimensions.fontSize26,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimensions.radiusSize30),
            borderSide: const BorderSide(width: 1.0, color: Colors.white),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimensions.radiusSize30),
            borderSide: const BorderSide(width: 1.0, color: Colors.white),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimensions.radiusSize30),
          ),
        ),
      ),
    );
  }
}
