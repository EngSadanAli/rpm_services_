import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../utils/app_colors.dart';

class RichTextWidgets extends StatelessWidget {
  String title;
  String text;
  final VoidCallback onPressed;

  RichTextWidgets({Key? key, required this.title, required this.text,
  required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: title,
        style: TextStyle(
          color: AppColors.blackText,
          fontWeight: FontWeight.w400,
          fontSize: 14.sp,
        ),
        children: [
          TextSpan(
            text: text,
            style: TextStyle(
              color: AppColors.textFieldBorderColor,
              fontWeight: FontWeight.w400,
              fontSize: 14.sp,
              // decoration: TextDecoration.underline,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = onPressed
          ),
        ],
      ),
    );
  }
}