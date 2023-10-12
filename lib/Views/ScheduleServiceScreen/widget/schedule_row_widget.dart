import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../ShopPart/Auth/Components/big_text.dart';
import '../../Utils/app_colors.dart';
class ScheduleRow extends StatelessWidget {
  String title;
  String text;
  ScheduleRow({super.key,required this.title,required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomText(title: title,
          fontWeight: FontWeight.w400,
          fontSize: 14.sp,
          color: AppColors.blackColor.withOpacity(.50),
        ),
        CustomText(title: text,
          fontWeight: FontWeight.w400,
          fontSize: 14.sp,
          color: AppColors.blackColor.withOpacity(.50),
        ),
      ],
    );
  }
}
