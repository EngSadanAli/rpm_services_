import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  String title;
  Color? color;
  FontWeight? fontWeight;
  double? fontSize;
  CustomText({Key? key,
    required this.title,
    this.color,
    this.fontWeight, this.fontSize,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        color: color,
        fontSize:fontSize,
        fontWeight: fontWeight,
      ),
    );
  }
}
