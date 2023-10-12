import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rpm/Views/Utils/app_images.dart';
import '../CommunicationScreen/video_text_communication_screen.dart';
import '../ServiceChargesScreen/service_charges_screen.dart';
import '../ShopPart/Auth/Components/big_text.dart';
import '../Utils/app_colors.dart';

class MyLocationScreen extends StatelessWidget {
   MyLocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.textFieldBorderColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            // Get.back();
            // _showProceedDialog(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: AppColors.whiteColor,
          ),
        ),
        title: CustomText(
          title: "My Location",
          fontWeight: FontWeight.w400,
          fontSize: 18.sp,
          color: AppColors.whiteColor,
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Image.asset(AppImages.mapImg,),
          ),
          Positioned(
              right: 10.w,
              bottom: 65.h,
              child: Icon(Icons.my_location)),
          Positioned(
              right: 10.w,
              bottom: 40.h,
              child: Icon(Icons.assistant_direction)),
        ],
      ),
      bottomNavigationBar: Container(
        height: 90.h,
        decoration: BoxDecoration(
          color: AppColors.textFieldBorderColor
        ),
        child:  InkWell(
          onTap: (){
            // showModalBottomSheet(
            //   context: context,
            //   builder: (BuildContext context) {
            //     return Container(
            //       height: 233.h,
            //       padding: EdgeInsets.all(10),
            //       decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(10.r),
            //         color: AppColors.whiteColor,
            //
            //       ),
            //       child: Column(
            //         mainAxisSize: MainAxisSize.min,
            //         children: [
            //           Row(
            //             children: [
            //               CircleAvatar(
            //                 backgroundImage: AssetImage(AppImages.profileImg),
            //               ),
            //               SizedBox(width: 8.w,),
            //               Column(
            //                 crossAxisAlignment: CrossAxisAlignment.start,
            //                 children: [
            //                   CustomText(
            //                     title: "Mr Jhon Albert",
            //                     fontWeight: FontWeight.w400,
            //                     fontSize: 13.sp,
            //                     color: AppColors.blackColor,
            //                   ),
            //                   SizedBox(height: 4.h),
            //                   Row(
            //                     children: [
            //                       CustomText(
            //                         title: "Rating",
            //                         fontWeight: FontWeight.w400,
            //                         fontSize: 11.sp,
            //                         color: AppColors.blackColor.withOpacity(.38),
            //                       ),
            //                       SizedBox(width:2.w,),
            //                       RatingBar(
            //                         itemSize: 10.sp,
            //                         initialRating: 3,
            //                         direction: Axis.horizontal,
            //                         allowHalfRating: true,
            //                         itemCount: 1,
            //                         ratingWidget: RatingWidget(
            //                           full: Icon(Icons.star, color: Colors.amber),
            //                           half: Icon(Icons.star_half, color: Colors.amber),
            //                           empty: Icon(Icons.star_border, color: Colors.grey),
            //                         ),
            //                         itemPadding: EdgeInsets.symmetric(horizontal: 4.0), // Space between stars
            //                         onRatingUpdate: (rating) {
            //                           // Handle the rating when it's updated
            //                           print(rating);
            //                         },
            //                       ),
            //                       SizedBox(width:2.w,),
            //                       CustomText(
            //                         title: "4.9",
            //                         fontWeight: FontWeight.w400,
            //                         fontSize: 11.sp,
            //                         color: AppColors.blackColor.withOpacity(.38),
            //                       ),
            //                     ],
            //                   ),
            //                 ],
            //               ),
            //               Spacer(),
            //               InkWell(
            //                 onTap: (){
            //                   Get.to(ServiceChargesScreen());
            //                 },
            //                 child: Container(
            //                   height: 31.h,
            //                   width: 93.w,
            //                   decoration:  BoxDecoration(
            //                     borderRadius: BorderRadius.circular(8),
            //                     color: AppColors.textFieldBorderColor,
            //                   ),
            //                   child: Center(
            //                     child: CustomText(
            //                       title: "Service Charges",
            //                       fontSize: 9.sp,
            //                       fontWeight: FontWeight.w400,
            //                       color: AppColors.whiteColor,
            //                     ),
            //                   ),
            //                 ),
            //               )
            //             ],
            //           ),
            //           SizedBox(height: 8.h,),
            //           Row(
            //             children: [
            //               Column(
            //                 children: [
            //                   Container(
            //                     height: 8.h,
            //                     width: 8.w,
            //                     decoration: BoxDecoration(
            //                       color: AppColors.redTextColor,
            //                       shape: BoxShape.circle,
            //                     ),
            //                   ),
            //                   Container(
            //                     height: 8.h,
            //                     width: 2.w,
            //                     decoration: BoxDecoration(
            //                       color: AppColors.grayText,
            //                     ),
            //                   ),
            //                 ],
            //               ),
            //               SizedBox(width: 10.w,),
            //               CustomText(
            //                 title: "1650 Cherry Drive Jacksnoweela road fl12",
            //                 fontSize: 13.sp,
            //                 fontWeight: FontWeight.w400,
            //                 color: AppColors.blackColor.withOpacity(.60),
            //               ),
            //             ],
            //           ),
            //           SizedBox(height: 8.h,),
            //           Row(
            //             children: [
            //              Image.asset(AppImages.deliveryImg),
            //               SizedBox(width: 10.w,),
            //               CustomText(
            //                 title: "Reaching in:",
            //                 fontSize: 13.sp,
            //                 fontWeight: FontWeight.w400,
            //                 color: AppColors.blackColor.withOpacity(.60),
            //               ),
            //               SizedBox(width: 10.w,),
            //               CustomText(
            //                 title: "15 Min",
            //                 fontSize: 13.sp,
            //                 fontWeight: FontWeight.w400,
            //                 color: AppColors.blackColor,
            //               ),
            //             ],
            //           ),
            //           SizedBox(height: 20.h,),
            //           Row(
            //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //             children: [
            //               CustomText(
            //                 title: "Contact Mechanic",
            //                 fontSize: 14.sp,
            //                 fontWeight: FontWeight.w400,
            //                 color: AppColors.textFieldBorderColor,
            //               ),
            //
            //               InkWell(
            //                 onTap: (){
            //                    // Get.to(VideoTextCommunication());
            //                 },
            //                 child: Container(
            //                   height: 31.h,
            //                   width: 78.w,
            //                   decoration: BoxDecoration(
            //                     borderRadius: BorderRadius.circular(4.r),
            //                     color: Color(0xffD1D1D1),
            //                   ),
            //                   child: Center(
            //                     child: CustomText(
            //                       title: "Call",
            //                       fontSize: 13.sp,
            //                       fontWeight: FontWeight.w400,
            //                       color: AppColors.whiteColor,
            //                     ),
            //                   ),
            //                 ),
            //               ),
            //               InkWell(
            //                 onTap: (){
            //                   Get.to(VideoTextCommunication());
            //                 },
            //                 child: Container(
            //                   height: 31.h,
            //                   width: 78.w,
            //                   decoration: BoxDecoration(
            //                     borderRadius: BorderRadius.circular(4.r),
            //                     color: AppColors.textFieldBorderColor,
            //                   ),
            //                   child: Center(
            //                     child: CustomText(
            //                       title: "Chat",
            //                       fontSize: 13.sp,
            //                       fontWeight: FontWeight.w400,
            //                       color: AppColors.whiteColor,
            //                     ),
            //                   ),
            //                 ),
            //               ),
            //             ],
            //           ),
            //           SizedBox(height: 20.h,),
            //           Row(
            //             mainAxisAlignment: MainAxisAlignment.center,
            //             children: [
            //               CustomText(
            //                 title: "Note:",
            //                 fontSize: 9.sp,
            //                 fontWeight: FontWeight.w400,
            //                 color: AppColors.blackColor.withOpacity(.90),
            //               ),
            //               CustomText(
            //                 title: "Payment will Take Place After The Service",
            //                 fontSize: 9.sp,
            //                 fontWeight: FontWeight.w400,
            //                 color: AppColors.blackColor.withOpacity(.60),
            //               ),
            //
            //
            //             ],
            //           ),
            //         ],
            //       ),
            //     );
            //   },
            // );

          },
          child: Container(
            margin: EdgeInsets.only(left: 60.w,right: 60.w,top: 20.h,bottom: 20.h),
            width: 288.w,
            height: 40.h,
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.35), // Shadow color
                    spreadRadius: 0,
                    blurRadius: 13,
                    offset: Offset(2, 2), // Offset in x and y direction
                  ),
                ],
                borderRadius: BorderRadius.circular(9.r),
                color: AppColors.whiteColor,
            ),
            child: Center(
              child: CustomText(
                title: "Book Service Now ",
                color: AppColors.blackColor.withOpacity(.87),
                fontWeight: FontWeight.w400,
                fontSize: 15.85.sp,
              ),
            ),
          ),
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
                 CustomText(title: "To Continue Turn On device\nLocation, Which uses Goolge’s\nLocation Service",
                   fontSize: 16.56.sp,
                   fontWeight: FontWeight.w400,
                   color: AppColors.blackColor.withOpacity(.70),
                 ),
                 SizedBox(height: 20.h),
                 CustomText(title: "Your Device Will Need to:",
                   fontSize: 16.56.sp,
                   fontWeight: FontWeight.w400,
                   color: AppColors.blackColor.withOpacity(.70),
                 ),
                 SizedBox(height: 20.h),
                 Row(
                   children: [
                     Icon(Icons.my_location,color: AppColors.blackColor.withOpacity(.70),),
                     SizedBox(width: 4.w),
                     CustomText(title: "Use GPS, Wi-Fi , Cell network,\nand Sensors. ",
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
                       onTap: (){
                         // Get.to(const SuccessScreen());
                       },
                       child: Container(
                         // padding: EdgeInsets.only(left: 20.w,right: 20.w),
                         width: 110.w,
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
                     SizedBox(width: 10.w,),
                     InkWell(
                       onTap: (){
                         // Get.to(const SuccessScreen());
                       },
                       child: Container(
                         // padding: EdgeInsets.only(left: 20.w,right: 20.w),
                         width: 110.w,
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
           actions: [
           ],
         );
       },
     );
   }
}
