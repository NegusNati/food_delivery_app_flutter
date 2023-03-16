// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';

class SmallText extends StatelessWidget {
  Color? color;
  final String text;
  double size;
  double height;
  SmallText({
    Key? key,
    this.color = const Color(0xFFccc7c5),
    required this.text,
    this.height = 1.2,
    this.size = 12,
  }) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: TextStyle(
          color: color,
          fontSize: size,
          fontFamily: 'Roboto',
          height: height,
        ));
  }
}
