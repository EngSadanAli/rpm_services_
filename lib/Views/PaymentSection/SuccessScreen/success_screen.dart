import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rpm/Views/ShopPart/Auth/Components/big_text.dart';
import 'package:rpm/widgets/bottom_navigation_bar.dart';
import '../../Utils/app_colors.dart';
import '../../Utils/app_images.dart';
class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:  EdgeInsets.only(left: 20.w,right: 20.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(AppImages.successImg),
            SizedBox(height: 20.h,),
            CustomText(title: "Payment Successful",
            color: AppColors.textFieldBorderColor,
              fontWeight: FontWeight.w400,
              fontSize: 32.sp,
            ),
            SizedBox(height: 10.h,),
            CustomText(title: "Your order has been confirmed",
            color: AppColors.blackColor.withOpacity(.70),
              fontWeight: FontWeight.w400,
              fontSize: 17.sp,
            ),
            SizedBox(height: 50.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: (){
                    Get.to(AppNavigationBar());
                  },
                  child: Container(
                    padding: EdgeInsets.only(left: 20.w,right: 20.w),
                    width: 150.w,
                    height: 38.w,
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
                    child: Center(
                      child: CustomText(
                        title: "Back To Home",
                        color: AppColors.textFieldBorderColor,
                        fontWeight: FontWeight.w400,
                        fontSize: 13.85.sp,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 20.w,),
                InkWell(
                  onTap: (){
                    Get.to(AppNavigationBar());
                  },
                  child: Container(
                    // padding: EdgeInsets.only(left: 20.w,right: 20.w),
                    width: 150.w,
                    height: 38.w,
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
                        color: AppColors.textFieldBorderColor),
                    child: Center(
                      child: CustomText(
                        title: "Done",
                        color: AppColors.whiteColor,
                        fontWeight: FontWeight.w400,
                        fontSize: 13.85.sp,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
