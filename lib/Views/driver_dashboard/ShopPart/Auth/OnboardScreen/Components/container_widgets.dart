import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rpm/utils/app_colors.dart';

class OnboardContainer extends StatelessWidget {
  String text;
  String title;
  String image;
   OnboardContainer({Key? key,
  required this.text,
  required this.title,
  required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(image,width: 410.w,height: 410.h,),
            SizedBox(height: 27.h,),

            Text(text,
              style: TextStyle(
                  color:AppColors.blackColor,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w400
              ),),
            SizedBox(height: 24.h,),
            Text(title,
              style: TextStyle(
                  color: AppColors.grayTextColor.withOpacity(0.58),
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w400
              ),),
          ],
        )
    );
  }
}
