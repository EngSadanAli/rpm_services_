import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rpm/Views/driver_dashboard/EmergencyServiceScreen/engine_service_screen.dart';
import 'package:rpm/Views/driver_dashboard/widgets/round_button.dart';
import 'package:rpm/utils/app_colors.dart';
import 'package:rpm/controllers/services/session_manager.dart';
import '../ScheduleServiceScreen/schedule_service_screen.dart';
import 'bottom_navigation_bar.dart';

class SelectionScreen extends StatelessWidget {
  const SelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(backgroundColor: Colors.blue),
      body: Center(
          child:
              // Container(
              //   width: 333,
              //   height: 357,
              //   decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(17),
              //       color: AppColors.textFieldBorderColor),
              //   child: Column(
              //     children: [
              //       SizedBox(
              //         height: 43.h,
              //       ),
              //       CustomText(
              //         title: "Welcome ${SessionController().name}",
              //         color: AppColors.whiteColor,
              //         fontWeight: FontWeight.w400,
              //         fontSize: 13.85.sp,
              //       ),
              //       SizedBox(
              //         height: 10.h,
              //       ),
              //       CustomText(
              //         title: "What would  you Like To",
              //         color: AppColors.whiteColor.withOpacity(0.90),
              //         fontWeight: FontWeight.w400,
              //         fontSize: 10.56.sp,
              //       ),
              //       SizedBox(
              //         height: 50.h,
              //       ),
              //       InkWell(
              //         onTap: () {
              //           Get.to(AppNavigationBar());
              //         },
              //         child: Container(
              //           width: 289.w,
              //           height: 52.w,
              //           decoration: BoxDecoration(
              //               borderRadius: BorderRadius.circular(17.r),
              //               color: AppColors.whiteColor),
              //           child: Center(
              //             child: CustomText(
              //               title: "Shop Parts",
              //               color: AppColors.blackColor,
              //               fontWeight: FontWeight.w400,
              //               fontSize: 15.85.sp,
              //             ),
              //           ),
              //         ),
              //       ),
              //       SizedBox(
              //         height: 35.h,
              //       ),
              //       InkWell(
              //         onTap: () {
              //           Get.to((SelectionTwoScreen()));
              //         },
              //         child: Container(
              //           width: 289.w,
              //           height: 52.h,
              //           decoration: BoxDecoration(
              //               borderRadius: BorderRadius.circular(17.r),
              //               color: Colors.white),
              //           child: Center(
              //             child: CustomText(
              //               title: "Service Request",
              //               color: AppColors.blackColor,
              //               fontWeight: FontWeight.w400,
              //               fontSize: 15.85.sp,
              //             ),
              //           ),
              //         ),
              //       ),
              //       SizedBox(
              //         height: 20.h,
              //       ),
              //     ],
              //   ),
              // ),
              Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        padding: EdgeInsets.only(right: 20, left: 20, top: 10),
        height: 280,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(17),
            color: AppColors.textFieldBorderColor),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Welcome ${SessionController().name}',
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(fontSize: 20),
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              'What would  you Like To',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            SizedBox(
              height: 30.h,
            ),
            RoundButton(
              title: 'Shop Parts',
              textColor: Colors.black,
              buttonColor: Colors.white,
              onPress: () {
                Get.to(AppNavigationBar());
              },
            ),
            SizedBox(
              height: 20.h,
            ),
            RoundButton(
              title: 'Service Request',
              textColor: Colors.black,
              buttonColor: Colors.white,
              onPress: () {
                Get.to((SelectionTwoScreen()));
              },
            ),
          ],
        ),
      )),
    );
  }
}

class SelectionTwoScreen extends StatelessWidget {
  const SelectionTwoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
            leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        )),
        body: Center(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            padding: EdgeInsets.only(right: 20, left: 20, top: 10),
            height: 280,
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(17),
                color: AppColors.textFieldBorderColor),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Welcome ${SessionController().name}',
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(fontSize: 20),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  'What would  you Like To',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                SizedBox(
                  height: 30.h,
                ),
                RoundButton(
                  title: 'Emergency Service',
                  textColor: Colors.white,
                  buttonColor: Colors.red,
                  onPress: () {
                    Get.to(EngineServiceScreen(
                      showBackButton: true,
                    ));
                  },
                ),
                SizedBox(
                  height: 20.h,
                ),
                RoundButton(
                  title: 'Schedule Service',
                  textColor: Colors.black,
                  buttonColor: Colors.white,
                  onPress: () {
                    Get.to(ScheduleServiceScreen());
                  },
                ),
              ],
            ),
          ),
          // Container(
          //   width: 333,
          //   height: 357,
          //   decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(17),
          //       color: AppColors.textFieldBorderColor),
          //   child: Column(
          //     children: [
          //       SizedBox(
          //         height: 43.h,
          //       ),
          //       CustomText(
          //         title: "Welcome ${SessionController().name.toString()}",
          //         color: AppColors.whiteColor,
          //         fontWeight: FontWeight.w400,
          //         fontSize: 13.85.sp,
          //       ),
          //       SizedBox(
          //         height: 10.h,
          //       ),
          //       CustomText(
          //         title: "What would  you Like To",
          //         color: AppColors.whiteColor.withOpacity(0.90),
          //         fontWeight: FontWeight.w400,
          //         fontSize: 10.56.sp,
          //       ),
          //       SizedBox(
          //         height: 50.h,
          //       ),
          //       InkWell(
          //         onTap: () {
          //           Get.to(EngineServiceScreen(
          //             showBackButton: true,
          //           ));
          //         },
          //         child: Container(
          //           width: 289.w,
          //           height: 52.w,
          //           decoration: BoxDecoration(
          //               borderRadius: BorderRadius.circular(17.r),
          //               color: AppColors.redTextColor),
          //           child: Center(
          //             child: CustomText(
          //               title: "Emergency Service",
          //               color: AppColors.whiteColor,
          //               fontWeight: FontWeight.w400,
          //               fontSize: 15.85.sp,
          //             ),
          //           ),
          //         ),
          //       ),
          //       SizedBox(
          //         height: 20.h,
          //       ),
          //       InkWell(
          //         onTap: () {
          //           Get.to(ScheduleServiceScreen());
          //         },
          //         child: Container(
          //           width: 289.w,
          //           height: 52.h,
          //           decoration: BoxDecoration(
          //               borderRadius: BorderRadius.circular(17.r),
          //               color: Colors.white),
          //           child: Center(
          //             child: CustomText(
          //               title: "Schedule Service",
          //               color: AppColors.blackColor,
          //               fontWeight: FontWeight.w400,
          //               fontSize: 15.85.sp,
          //             ),
          //           ),
          //         ),
          //       ),
          //       SizedBox(
          //         height: 10.h,
          //       ),
          //     ],
          //   ),
          // ),
        ),
      ),
    );
  }
}
