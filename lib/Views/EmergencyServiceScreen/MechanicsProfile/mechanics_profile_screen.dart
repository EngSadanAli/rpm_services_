import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rpm/Views/Utils/app_images.dart';
import '../../CommunicationScreen/video_text_communication_screen.dart';
import '../../ServiceChargesScreen/service_charges_screen.dart';
import '../../ShopPart/Auth/Components/big_text.dart';
import '../../Utils/app_colors.dart';

class MechanicsProfileScreen extends StatefulWidget {
   MechanicsProfileScreen({super.key});

  @override
  State<MechanicsProfileScreen> createState() => _MechanicsProfileScreenState();
}

class _MechanicsProfileScreenState extends State<MechanicsProfileScreen> {
  final PageController _pageController = PageController(initialPage: 0);

  double rating = 0.0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.whiteColor,
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
          title: "Mechanics Profile ",
          fontWeight: FontWeight.w400,
          fontSize: 18.sp,
          color: AppColors.blackColor,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(
          left: 16.w,
          right: 16.w,
          top: 10.h
        ),
        child: Column(
          children: [
            ListView.builder(
              itemCount: 2,
              shrinkWrap: true,
              itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.only(top: 10.h),
                height: 200.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(19.r),
                  color: AppColors.whiteColor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25), // Shadow color
                      spreadRadius: 0,
                      blurRadius: 4,
                      offset: Offset(0, 4), // Offset in x and y direction
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                title: "Mr Jhon Albert",
                                fontWeight: FontWeight.w400,
                                fontSize: 13.sp,
                                color: AppColors.blackColor,
                              ),
                              CustomText(
                                title: "Mechanic",
                                fontWeight: FontWeight.w400,
                                fontSize: 13.sp,
                                color: AppColors.blackColor.withOpacity(.38),
                              ),
                            ],
                          ),
                          Spacer(),
                          CircleAvatar(
                            backgroundImage: AssetImage(AppImages.profileImg),
                          ),
                        ],
                      ),
                      SizedBox(height: 15.h,),
                      Divider(thickness: 2,color: AppColors.blackColor.withOpacity(.25),),
                      SizedBox(height: 15.h,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                title: "Experience",
                                fontWeight: FontWeight.w400,
                                fontSize: 13.sp,
                                color: AppColors.blackColor.withOpacity(.38),
                              ),
                              CustomText(
                                title: "5 years",
                                fontWeight: FontWeight.w500,
                                fontSize: 13.sp,
                                color: AppColors.blackColor,
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                title: "Client Review",
                                fontWeight: FontWeight.w400,
                                fontSize: 13.sp,
                                color: AppColors.blackColor.withOpacity(.38),
                              ),
                              CustomText(
                                title: "Excellent",
                                fontWeight: FontWeight.w500,
                                fontSize: 13.sp,
                                color: AppColors.blackColor,
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                title: "Rating",
                                fontWeight: FontWeight.w400,
                                fontSize: 13.sp,
                                color: AppColors.blackColor.withOpacity(.38),
                              ),
                              CustomText(
                                title: "4.9",
                                fontWeight: FontWeight.w500,
                                fontSize: 13.sp,
                                color: AppColors.blackColor,
                              ),
                              RatingBar.builder(
                                itemSize: 10.42.sp,
                                initialRating: rating,
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                // itemPadding: EdgeInsets.symmetric(horizontal: 2.w),
                                itemBuilder: (context, _) => const Icon(
                                  Icons.star,
                                  color: Color(0xffF3CD03),
                                ),
                                onRatingUpdate: (newRating) {
                                  rating = newRating; // Update the rating value
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 25.h,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: (){
                              // Get.to(ServiceChargesScreen());
                            },
                            child: Container(
                              // padding: EdgeInsets.only(left: 20.w,right: 20.w),
                              width: 92.w,
                              height: 38.w,
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.35), // Shadow color
                                      spreadRadius: 0,
                                      blurRadius: 4,
                                      offset: Offset(0, 3), // Offset in x and y direction
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(10.r),
                                  color: AppColors.whiteColor),
                              child: Center(
                                child: CustomText(
                                  title: "Schedule",
                                  color: AppColors.blackColor.withOpacity(.87),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13.85.sp,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 15.w,),
                          GestureDetector(
                            onTap: (){
                              // Get.to(VideoTextCommunication());
                            },
                            child: Container(
                              // padding: EdgeInsets.only(left: 20.w,right: 20.w),
                              width: 92.w,
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
                                  borderRadius: BorderRadius.circular(10.r),
                                  color: AppColors.textFieldBorderColor),
                              child: Center(
                                child: CustomText(
                                  title: "Book Now",
                                  color: AppColors.whiteColor,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13.85.sp,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },)
          ],
        ),
      ),
    );
  }
}
