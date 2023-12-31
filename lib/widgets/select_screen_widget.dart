import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rpm/Views/Utils/app_colors.dart';
import '../Views/ScheduleServiceScreen/schedule_service_screen.dart';
import '../Views/ShopPart/Auth/Components/big_text.dart';
import 'bottom_navigation_bar.dart';
class SelectionScreen extends StatelessWidget {
  const SelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 333,
          height: 357,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(17),
              color: AppColors.textFieldBorderColor),
          child: Column(
            children: [
              SizedBox(
                height: 43.h,
              ),
              CustomText(
                title: "Welcome Mr Jhon",
                color: AppColors.whiteColor,
                fontWeight: FontWeight.w400,
                fontSize: 15.85.sp,
              ),
              SizedBox(height: 10.h,),
              CustomText(
                title: "What would  you Like To",
                color: AppColors.whiteColor.withOpacity(0.90),
                fontWeight: FontWeight.w400,
                fontSize: 10.56.sp,
              ),
              SizedBox(height: 50.h,),
              InkWell(
                onTap: (){
                  Get.to(AppNavigationBar());
                },
                child: Container(
                  width: 289.w,
                  height: 52.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(17.r),
                      color: AppColors.whiteColor),
                  child: Center(
                    child: CustomText(
                      title: "Shop Parts",
                      color: AppColors.blackColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 15.85.sp,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 35.h,),
              InkWell(
                onTap: (){
                  Get.to(ScheduleServiceScreen());
                },
                child: Container(
                  width: 289.w,
                  height: 52.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(17.r),
                      color: Colors.white),
                  child: Center(
                    child:CustomText(
                      title: "Service Request",
                      color: AppColors.blackColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 15.85.sp,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.h,),
            ],
          ),
        ),
      ),
    );
  }
}
