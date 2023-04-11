// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:food_delivery_app/utills/dimensions.dart';

class NoCartPage extends StatelessWidget {
  final String text;
  final String imgPath;
  const NoCartPage({
    Key? key,
    required this.text,
    this.imgPath = "assets/image/empty_cart.png",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: Dimensions.Height15,
        ),
        Image.asset(
          imgPath,
          height: Dimensions.Height30 * 8,
          width: Dimensions.Width30 * 8,
        ),
        SizedBox(
          height: Dimensions.Height15,
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: Dimensions.fontSize16,
            color: Theme.of(context).disabledColor,
          ),
        ),
      ],
    );
  }
}
