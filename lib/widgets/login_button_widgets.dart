import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class ButtonWidgets extends StatelessWidget {
  final VoidCallback onPressed;
  final Color color;
  final Color textColor;
  String title;
   ButtonWidgets({Key? key,

  required this.onPressed,
  required this.color,
  required this.textColor,
  required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 50.h,
        width: 156.w,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(title,
            style: TextStyle(
              color: textColor,
              fontSize: 18.sp,
              fontWeight: FontWeight.w400
            ),
          ),
        ),
      ),
    );
  }
}
