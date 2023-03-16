// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:food_delivery_app/utills/dimensions.dart';

class BigText extends StatelessWidget {
  Color? color;
  final String text;
  double size;
  TextOverflow overFlow;

  BigText({
    Key? key,
    this.color = const Color(0xFF332d2b),
    required this.text,
    this.size = 0,
    this.overFlow = TextOverflow.ellipsis,
  }) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Text(text,
        maxLines: 1,
        overflow: overFlow,
        style: TextStyle(
          color: color,
          fontSize: size == 0 ? Dimensions.fontSize20 : size,
          fontWeight: FontWeight.w400,
          fontFamily: 'Roboto',
        ));
  }
}
