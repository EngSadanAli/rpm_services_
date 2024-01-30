import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../ShopPart/Auth/Components/big_text.dart';
import '../../Utils/app_colors.dart';
class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  bool switchValue = false;
  bool switchValue1 = false;
  bool switchValue2 = false;
  bool switchValue3 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: CustomText(
          title: "Notification",
          fontWeight: FontWeight.w700,
          fontSize: 18.sp,
          color: AppColors.blackColor.withOpacity(.87),
        ),
      ),
      body: Padding(
        padding:  EdgeInsets.only(left: 16.sp,right: 16.sp,top: 10.h),
        child: Padding(
          padding:  EdgeInsets.only(left: 20.w,right: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(title: "Notification Setting",
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.blackColor,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(title: "Show Notifications",
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.blackColor.withOpacity(.87),
                  ),
                  Switch(
                    value: switchValue,
                    onChanged: (newValue) {

                      setState(() {
                        switchValue = newValue;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 6.h,),
              Divider(thickness: 1,color: AppColors.blackColor.withOpacity(.38),),
              SizedBox(height: 5.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(title: "Show Notifications",
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.blackColor.withOpacity(.87),
                  ),
                  Switch(
                    value: switchValue1,
                    onChanged: (newValue) {

                      setState(() {
                        switchValue1 = newValue;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 5.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(title: "Show Notifications",
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.blackColor.withOpacity(.87),
                  ),
                  Switch(
                    value: switchValue2,
                    onChanged: (newValue) {

                      setState(() {
                        switchValue2 = newValue;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 5.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(title: "Show Notifications",
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.blackColor.withOpacity(.87),
                  ),
                  Switch(
                    value: switchValue3,
                    onChanged: (newValue) {

                      setState(() {
                        switchValue3 = newValue;
                      });
                    },
                  ),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}
