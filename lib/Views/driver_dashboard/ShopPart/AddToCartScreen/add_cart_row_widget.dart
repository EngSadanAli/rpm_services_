import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/app_colors.dart';
import '../Auth/Components/big_text.dart';
class AddToCartRowText extends StatelessWidget {
  String title;
  String text;
   AddToCartRowText({super.key,required this.title,required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(title: title,
          fontSize: 11.50.sp,
          fontWeight: FontWeight.w400,
          color: AppColors.blackColor.withOpacity(.90),
        ),
        CustomText(title: text,
          fontSize: 11.50.sp,
          fontWeight: FontWeight.w400,
          color: AppColors.blackColor,
        ),
      ],
    );
  }
}
