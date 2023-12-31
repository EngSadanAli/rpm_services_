import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rpm/Views/Utils/app_colors.dart';
import '../ShopPart/Auth/Components/big_text.dart';
import 'AccountSetting/account_setting_screen.dart';
import 'NotificationScreen/notification_screen.dart';
import 'container_widget.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
        title: "Setting ",
        fontWeight: FontWeight.w400,
        fontSize: 18.sp,
        color: AppColors.blackColor,
      ),
    ),
      body: Padding(
        padding:  EdgeInsets.only(left:15.w,right: 15.w,top: 20.h),
        child: Column(
          children: [
            SettingContainerWidget(
              onTap: (){
                // Get.to( AccountSettingScreen());
              },
              title: "Account",
              icon: const Icon(Icons.person_outline),
            ),
            SizedBox(height: 10.h,),
            SettingContainerWidget(
              onTap: (){
                Get.to(const NotificationScreen());
              },
              title: "Notification",
              icon: const Icon(Icons.notifications_outlined),
            ),
            SizedBox(height: 10.h,),
            SettingContainerWidget(
              onTap: (){},
              title: "Theme",
              icon: const Icon(Icons.wb_sunny,  ),
            ),
            SizedBox(height: 10.h,),
            SettingContainerWidget(
              onTap: (){},
              title: "LogOut",
              icon: const Icon(Icons.logout_outlined),
            ),
          ],
        ),
      ),
    );
  }
}
