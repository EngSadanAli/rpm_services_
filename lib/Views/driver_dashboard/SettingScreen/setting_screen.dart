import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rpm/Views/driver_dashboard/ShopPart/Auth/LogInScreen/login_screen.dart';
import 'package:rpm/utils/app_colors.dart';
import 'package:rpm/Views/profile/profile_screen.dart';
import 'package:rpm/controllers/services/session_manager.dart';
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
        // leading: IconButton(
        //   onPressed: () {
        //     Get.back();
        //   },
        //   icon: Icon(
        //     Icons.arrow_back,
        //     color: Colors.black,
        //   ),
        // ),
        title: CustomText(
          title: "Setting ",
          fontWeight: FontWeight.w400,
          fontSize: 18.sp,
          color: AppColors.blackColor,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 20.h),
        child: Column(
          children: [
            SettingContainerWidget(
              onTap: () {
                Get.to(ProfileScreen(showBackButton: true));
              },
              title: "Account",
              icon: const Icon(Icons.person_outline),
            ),
            SizedBox(
              height: 10.h,
            ),
            // SettingContainerWidget(
            //   onTap: () {
            //     Get.to(const NotificationScreen());
            //   },
            //   title: "Notification",
            //   icon: const Icon(Icons.notifications_outlined),
            // ),
            // SizedBox(
            //   height: 10.h,
            // ),
            // SettingContainerWidget(
            //   onTap: () {},
            //   title: "Theme",
            //   icon: const Icon(
            //     Icons.wb_sunny,
            //   ),
            // ),
            SizedBox(
              height: 10.h,
            ),
            SettingContainerWidget(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog.adaptive(
                      title: Text('Logout'),
                      content: Text('Are you sure you want to logout?'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            // // Perform logout action here
                            // Navigator.of(context).pop(); // Close the dialog
                            FirebaseAuth.instance.signOut().then((value) {
                              SessionController().userId = '';
                              SessionController().profilePic = '';
                              SessionController().name = '';
                              SessionController().email = '';
                              SessionController().phone = '';
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LoginScreen(),
                                  ),
                                  (route) => false);
                            });
                          },
                          child: Text('OK'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(); // Close the dialog
                          },
                          child: Text('Cancel'),
                        ),
                      ],
                    );
                  },
                );
              },
              title: "LogOut",
              icon: const Icon(Icons.logout_outlined),
            ),
          ],
        ),
      ),
    );
  }
}
