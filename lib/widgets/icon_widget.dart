// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:food_delivery_app/widgets/small_text.dart';

class IconWidget extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color iconColor;

  const IconWidget({
    Key? key,
    required this.text,
    required this.icon,
    required this.iconColor,
  }) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Icon(icon, color: iconColor),
      const SizedBox(width: 5),
      SmallText(text: text),
    ]);
  }
}
