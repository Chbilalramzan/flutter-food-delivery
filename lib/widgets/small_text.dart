import 'package:flutter/material.dart';

class SmallText extends StatelessWidget {
  Color? color;
  final String text;
  double size, height;
  TextOverflow overflow;
  SmallText(
      {Key? key,
      this.color = const Color(0xFFccc7c5),
      this.size = 12,
      this.height = 1.2,
      required this.text,
      this.overflow = TextOverflow.ellipsis})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overflow,
      maxLines: 1,
      style: TextStyle(
          fontSize: size, color: color, fontFamily: 'Roboto', height: height),
    );
  }
}
