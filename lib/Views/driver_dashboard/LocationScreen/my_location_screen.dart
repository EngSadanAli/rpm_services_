import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rpm/Views/driver_dashboard/ShopPart/ShopHomeScreen/ProductDescriptionScreen/product_description_screen.dart';
import 'package:rpm/utils/app_images.dart';
import 'package:rpm/controllers/services/session_manager.dart';
import 'package:rpm/utils/utils.dart';
import '../CommunicationScreen/video_text_communication_screen.dart';
import '../ServiceChargesScreen/service_charges_screen.dart';
import '../ShopPart/Auth/Components/big_text.dart';
import '../../../utils/app_colors.dart';
import 'package:http/http.dart' as http;

class MyWishlistScreen extends StatelessWidget {
  final bool showBackButton;
  MyWishlistScreen({super.key, required this.showBackButton});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: AppColors.whiteColor,
        appBar: AppBar(
          centerTitle: true,
          // backgroundColor: AppColors.textFieldBorderColor,
          elevation: 0,
          // leading: IconButton(
          //   onPressed: () {
          //     // Get.back();
          //     // _showProceedDialog(context);
          //   },
          //   icon: Icon(
          //     Icons.arrow_back,
          //     color: AppColors.whiteColor,
          //   ),
          // ),
          title: Text('My Wishlist'),
          leading: showBackButton
              ? IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ))
              : SizedBox.shrink(),
        ),
        // body: Stack(
        //   children: [
        //     SingleChildScrollView(
        //       child: Image.asset(
        //         AppImages.mapImg,
        //       ),
        //     ),
        //     Positioned(right: 10.w, bottom: 65.h, child: Icon(Icons.my_location)),
        //     Positioned(
        //         right: 10.w,
        //         bottom: 40.h,
        //         child: Icon(Icons.assistant_direction)),
        //   ],
        // ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('products')
              .where('favorite', arrayContains: SessionController().userId)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("Loading");
            }
            if (snapshot.data!.docs.length == 0) {
              return Center(
                  child: Text(
                'No Data',
                style: TextStyle(color: AppColors.blackColor),
              ));
            }
            return Padding(
              padding: const EdgeInsets.only(top: 10),
              child: GridView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data!.docs.length,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 1.5 / 2,
                  crossAxisSpacing: 12,
                  mainAxisExtent: 150,
                  mainAxisSpacing: 20,
                ),
                itemBuilder: (context, index) {
                  var snap = snapshot.data!.docs[index];
                  return Padding(
                    padding: EdgeInsets.only(right: 10.w, left: 10),
                    child: GestureDetector(
                      onTap: () {
                        Get.to(ProductDescriptionScreen(snap: snap));
                      },
                      child: Container(
                        padding:
                            EdgeInsets.only(top: 10.h, left: 8.w, right: 8.w),
                        height: 146.h,
                        width: 165.w,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: AppColors.grayText),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black
                                  .withOpacity(0.25), // Shadow color
                              spreadRadius: 0,
                              blurRadius: 4,
                              offset:
                                  Offset(0, 4), // Offset in x and y direction
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Image.asset(AppImages.pngWingImg),
                            SizedBox(
                              height: 4.h,
                            ),
                            CustomText(
                              title: snap['title'],
                              color: AppColors.blackColor,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                            ),
                            SizedBox(
                              height: 6.h,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomText(
                                  title: "\$",
                                  color: AppColors.blackColor.withOpacity(.50),
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                CustomText(
                                  title: snap['price'],
                                  color: AppColors.blackColor.withOpacity(.50),
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                                // SizedBox(
                                //   width: 10.w,
                                // ),
                                // CustomText(
                                //   title: "10% off",
                                //   color: AppColors.redTextColor,
                                //   fontSize: 10.sp,
                                //   fontWeight: FontWeight.w400,
                                // ),
                                Spacer(),
                                StreamBuilder<DocumentSnapshot>(
                                  stream: FirebaseFirestore.instance
                                      .collection('products')
                                      .doc(snap['docId'])
                                      .snapshots(),
                                  builder: (context, AsyncSnapshot snapshot) {
                                    if (snapshot.hasError) {
                                      return Text('Something went wrong');
                                    }

                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return Text("Loading");
                                    }

                                    return GestureDetector(
                                      onTap: () async {
                                        try {
                                          if (snapshot.data
                                              .get("favorite")
                                              .contains(
                                                  SessionController().userId)) {
                                            await FirebaseFirestore.instance
                                                .collection('products')
                                                .doc(snap['docId'])
                                                .update({
                                              'favorite':
                                                  FieldValue.arrayRemove([
                                                SessionController().userId
                                              ])
                                            }).then((value) {
                                              Utils.flushBarDoneMessage(
                                                  'Item removed from favorite',
                                                  context);
                                            });
                                          } else {
                                            await FirebaseFirestore.instance
                                                .collection('products')
                                                .doc(snap['docId'])
                                                .update({
                                              'favorite': FieldValue.arrayUnion(
                                                  [SessionController().userId])
                                            }).then((value) {
                                              Utils.flushBarDoneMessage(
                                                  'Item added to favorite',
                                                  context);
                                            });
                                          }
                                        } catch (e) {}
                                      },
                                      child: Center(
                                          child: Icon(
                                        snapshot.data.get("favorite").contains(
                                                SessionController().userId)
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        size: 14.sp,
                                        color: AppColors.grayText,
                                      )),
                                    );
                                  },
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }

  void _showProceedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xffF7F7F7),
          content: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomText(
                  title:
                      "To Continue Turn On device\nLocation, Which uses Goolge’s\nLocation Service",
                  fontSize: 16.56.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.blackColor.withOpacity(.70),
                ),
                SizedBox(height: 20.h),
                CustomText(
                  title: "Your Device Will Need to:",
                  fontSize: 16.56.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.blackColor.withOpacity(.70),
                ),
                SizedBox(height: 20.h),
                Row(
                  children: [
                    Icon(
                      Icons.my_location,
                      color: AppColors.blackColor.withOpacity(.70),
                    ),
                    SizedBox(width: 4.w),
                    CustomText(
                      title: "Use GPS, Wi-Fi , Cell network,\nand Sensors. ",
                      fontSize: 16.56.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.blackColor.withOpacity(.70),
                    ),
                  ],
                ),
                SizedBox(height: 50.h),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        // Get.to(const SuccessScreen());
                      },
                      child: Container(
                        // padding: EdgeInsets.only(left: 20.w,right: 20.w),
                        width: 110.w,
                        height: 38.w,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey
                                    .withOpacity(0.35), // Shadow color
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset:
                                    Offset(1, 3), // Offset in x and y direction
                              ),
                            ],
                            borderRadius: BorderRadius.circular(17.r),
                            color: AppColors.textFieldBorderColor),
                        child: Center(
                          child: CustomText(
                            title: "No Thanks",
                            color: AppColors.whiteColor,
                            fontWeight: FontWeight.w400,
                            fontSize: 13.85.sp,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    InkWell(
                      onTap: () {
                        // Get.to(const SuccessScreen());
                      },
                      child: Container(
                        // padding: EdgeInsets.only(left: 20.w,right: 20.w),
                        width: 110.w,
                        height: 38.w,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey
                                    .withOpacity(0.35), // Shadow color
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset:
                                    Offset(1, 3), // Offset in x and y direction
                              ),
                            ],
                            borderRadius: BorderRadius.circular(17.r),
                            color: AppColors.textFieldBorderColor),
                        child: Center(
                          child: CustomText(
                            title: "Share Location",
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
          actions: [],
        );
      },
    );
  }
}
