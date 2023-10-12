import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rpm/Views/PaymentSection/AddressScreem/widgets/textfield_widget.dart';
import 'package:rpm/Views/ShopPart/Auth/Components/big_text.dart';

import '../../../widgets/bottom_navigation_bar.dart';
import '../../ShopPart/ShopHomeScreen/home_service_request.dart';
import '../../Utils/app_colors.dart';
import '../../Utils/app_images.dart';
class AddressScreen extends StatelessWidget {
   AddressScreen({super.key});
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final cityController = TextEditingController();
  final addressController = TextEditingController();
  final phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
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
          title: "Address",
          fontWeight: FontWeight.w400,
          fontSize: 18.sp,
          color: AppColors.blackColor,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.shopping_cart_outlined,
              color: AppColors.blackColor,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.only(left: 16.w,right: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(title: "Delivery Address",
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.blackColor,),
              SizedBox(height: 21.sp),
              Center(
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      color: Color(0xffF8F8F8)),
                  child: Padding(
                    padding:  EdgeInsets.only(left: 4.w,right: 4.w,top: 20.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(title: "Full Name",
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.blackColor,
                        ),
                        SizedBox(height: 5.h,),
                        AddressTextFieldWidget(
                          readOnly: false,
                          controller: nameController,
                          onFieldSubmittedValue: (newValue) {},
                          keyBoardType: TextInputType.text,
                          obscureText: false,
                          hint: 'Your Name',
                          onChange: (value) {},
                          validator: (value) {
                            if (!GetUtils.isEmail(value!)) {
                              return "Please enter Your Name";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 37.h),
                        CustomText(title: "Email Address",
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.blackColor,),
                        SizedBox(height: 5.h,),
                        AddressTextFieldWidget(
                          readOnly: false,
                          controller: emailController,
                          onFieldSubmittedValue: (newValue) {},
                          keyBoardType: TextInputType.emailAddress,
                          obscureText: false,
                          hint: 'example@email.com',
                          onChange: (value) {},
                          validator: (value) {
                            if (!GetUtils.isEmail(value!)) {
                              return "Please enter Your Valid Email";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 30.h),
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(title: "City",
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.blackColor,),
                                SizedBox(height: 5.h,),
                                SizedBox(
                                  height: 45.h,
                                  width: 154.w,
                                  child:AddressTextFieldWidget(
                                    readOnly: false,
                                    controller: cityController,
                                    onFieldSubmittedValue: (newValue) {},
                                    keyBoardType: TextInputType.text,
                                    obscureText: false,
                                    hint: 'Your City',
                                    onChange: (value) {},
                                    validator: (value) {
                                      if (!GetUtils.isEmail(value!)) {
                                        return "Please enter Your City";
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: 10.w,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(title: "Postal Address",
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.blackColor,),
                                SizedBox(height: 5.h,),

                                SizedBox(
                                  height: 45.h,
                                  width: 154.w,
                                  child: AddressTextFieldWidget(
                                    readOnly: false,
                                    controller: addressController,
                                    onFieldSubmittedValue: (newValue) {},
                                    keyBoardType: TextInputType.text,
                                    obscureText: false,
                                    hint: 'Your City',
                                    onChange: (value) {},
                                    validator: (value) {
                                      if (!GetUtils.isEmail(value!)) {
                                        return "Please enter Your Address";
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),

                          ],
                        ),
                        SizedBox(height: 24.h),
                        CustomText(title: "Phone Number",
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.blackColor,),
                        SizedBox(height: 5.h,),
                        AddressTextFieldWidget(
                          readOnly: false,
                          controller: phoneController,
                          onFieldSubmittedValue: (newValue) {},
                          keyBoardType: TextInputType.phone,
                          obscureText: false,
                          hint: 'Phone Number',
                          onChange: (value) {},
                          validator: (value) {
                            if (!GetUtils.isEmail(value!)) {
                              return "Please enter Your Phone Number";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20.h,),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 60.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: (){
                      Get.to(AppNavigationBar());
                    },
                    child: Container(
                      width: 143,
                      height: 38,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.35), // Shadow color
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(1, 3), // Offset in x and y direction
                            ),
                          ],
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xffF3F5F7)),
                      child: Center(
                        child: Text('Continue Shopping',
                            style: TextStyle(
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w400,
                                color: AppColors.textFieldBorderColor)),
                      ),
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: (){
                      // _showReviewDialog(context);
                    },
                    child: Container(
                      width: 143,
                      height: 38,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.25), // Shadow color
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(0, 3), // Offset in x and y direction
                            ),
                          ],
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xff0061BF)),
                      child: Center(
                        child: Text('Proceed to Checkout',
                            style: TextStyle(
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w400,
                                color: Colors.white)),
                      ),
                    ),
                  ),
                ],
              )

            ],
          ),
        ),
      ),
    );
  }
   // void _showReviewDialog(BuildContext context) {
   //   showDialog(
   //     context: context,
   //     builder: (BuildContext context) {
   //       return AlertDialog(
   //         backgroundColor: AppColors.textFieldBorderColor,
   //         content: Form(
   //           child: Column(
   //             crossAxisAlignment: CrossAxisAlignment.center,
   //             mainAxisSize: MainAxisSize.min,
   //             children: [
   //               CustomText(title: "Mr Jhon",
   //                 fontSize: 15.50.sp,
   //                 fontWeight: FontWeight.w400,
   //                 color: AppColors.whiteColor,
   //               ),
   //               SizedBox(height: 10.h),
   //               CustomText(title: "What would  you Like To ",
   //                 fontSize: 10.56.sp,
   //                 fontWeight: FontWeight.w400,
   //                 color: AppColors.whiteColor,
   //               ),
   //               SizedBox(height: 30.h),
   //               InkWell(
   //                 onTap: (){
   //                   // Get.to(AppNavigationBar());
   //                 },
   //                 child: Container(
   //                   width: 289.w,
   //                   height: 52.w,
   //                   decoration: BoxDecoration(
   //                       borderRadius: BorderRadius.circular(17.r),
   //                       color: AppColors.whiteColor),
   //                   child: Row(
   //                     crossAxisAlignment: CrossAxisAlignment.center,
   //                     mainAxisAlignment: MainAxisAlignment.center,
   //                     children: [
   //                       Image.asset(AppImages.addressImg),
   //                       SizedBox(width: 10.w,),
   //                       CustomText(
   //                         title: "Self Pick-Up Order",
   //                         color: AppColors.blackColor,
   //                         fontWeight: FontWeight.w400,
   //                         fontSize: 15.85.sp,
   //                       ),
   //                     ],
   //                   ),
   //                 ),
   //               ),
   //               SizedBox(height: 15.h),
   //               InkWell(
   //                 onTap: (){
   //                   Get.to(AddressScreen());
   //                 },
   //                 child: Container(
   //                   width: 289.w,
   //                   height: 52.w,
   //                   decoration: BoxDecoration(
   //                       borderRadius: BorderRadius.circular(17.r),
   //                       color: AppColors.whiteColor),
   //                   child: Row(
   //                     crossAxisAlignment: CrossAxisAlignment.center,
   //                     mainAxisAlignment: MainAxisAlignment.center,
   //                     children: [
   //                       Image.asset(AppImages.expressDeliveryImg),
   //                       SizedBox(width: 10.w,),
   //                       CustomText(
   //                         title: "Home Delivery     ",
   //                         color: AppColors.blackColor,
   //                         fontWeight: FontWeight.w400,
   //                         fontSize: 15.85.sp,
   //                       ),
   //                     ],
   //                   ),
   //                 ),
   //               ),
   //               SizedBox(height: 30.h),
   //             ],
   //           ),
   //         ),
   //         actions: [
   //         ],
   //       );
   //     },
   //   );
   // }
}
