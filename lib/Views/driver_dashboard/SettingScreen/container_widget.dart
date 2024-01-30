import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../ShopPart/Auth/Components/big_text.dart';
import '../../../utils/app_colors.dart';
class SettingContainerWidget extends StatelessWidget {
   final Icon  icon;
   String  title;
   final VoidCallback onTap;
   SettingContainerWidget({super.key,required this.onTap,required this.icon,required this.title,});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.only(left: 20.w,right: 20.w),
        width: 378.w,
        height: 60.w,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.35), // Shadow color
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(1, 3), // Offset in x and y direction
              ),
            ],
            borderRadius: BorderRadius.circular(9.r),
            color: AppColors.whiteColor),
        child: Row(

          children: [
            Container(
              height: 40.h,
              width: 40.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.greySeTextColor),
              ),
              child: Icon(icon.icon,color: AppColors.blackColor,),
            ),
            SizedBox(width: 10.w,),
            CustomText(
              title: title,
              color: AppColors.blackColor,
              fontWeight: FontWeight.w500,
              fontSize: 14.85.sp,
            ),
            Spacer(),
            Icon(Icons.arrow_forward_ios,color: AppColors.garyIconColor,)
          ],
        ),
      ),
    );
  }
}
