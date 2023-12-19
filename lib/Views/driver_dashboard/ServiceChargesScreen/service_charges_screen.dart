import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../PaymentSection/AddressScreem/home_address_screem.dart';
import '../PaymentSection/SuccessScreen/success_screen.dart';
import '../ShopPart/AddToCartScreen/add_cart_row_widget.dart';
import '../ShopPart/Auth/Components/big_text.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_images.dart';
class ServiceChargesScreen extends StatefulWidget {
  const ServiceChargesScreen({super.key});

  @override
  State<ServiceChargesScreen> createState() => _ServiceChargesScreenState();
}

class _ServiceChargesScreenState extends State<ServiceChargesScreen> {
  bool _value = false;
  bool _value1 = false;
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
          title: "Service Charges",
          fontWeight: FontWeight.w400,
          fontSize: 18.sp,
          color: AppColors.blackColor,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container(
              // height: 447.h,
              decoration: BoxDecoration(
                color: Color(0xffF8F8F8)
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    AddToCartRowText(
                      title: "Engine Oil Price",
                      text: "\$${ 20.00}",
                    ),
                    SizedBox(height: 8.h,),
                    AddToCartRowText(
                      title: "Service Charges",
                      text: "\$${ 10000.00}",
                    ),
                    SizedBox(height: 10.h,),
                    AddToCartRowText(
                      title: "Far Charges",
                      text: "\$${ 40.00}",
                    ),
                    SizedBox(height: 8.h,),
                    AddToCartRowText(
                      title: "Discount",
                      text: "${ 10}%",
                    ),
                    SizedBox(height: 10.h,),
                    Divider(color: Color(0xffE8E8E8),thickness: 1,),
                    SizedBox(height: 10.h,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(title: "Total",
                          fontSize: 12.50.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.blackColor.withOpacity(.90),
                        ),
                        CustomText(title: "\$${1.3827}",
                          fontSize: 12.50.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textColorB,
                        ),
                      ],
                    ),
                    SizedBox(height: 80.h,),
                    InkWell(
                      onTap: (){
                        _showProceedDialog(context);
                      },
                      child: Container(
                        // padding: EdgeInsets.only(left: 20.w,right: 20.w),
                        width: 143.w,
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
                            title: "Proceed to Payment",
                            color: AppColors.whiteColor,
                            fontWeight: FontWeight.w400,
                            fontSize: 13.85.sp,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30.h,),
                  ],
                ),
              ),
            )
          ],
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
                CustomText(title: "Payment Methods",
                  fontSize: 17.50.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.blackColor.withOpacity(.87),
                ),
                SizedBox(height: 10.h),
                CustomText(title: "Select a payment method to continue.",
                  fontSize: 11.56.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.blackColor.withOpacity(.38),
                ),
                SizedBox(height: 30.h),
                InkWell(
                  onTap: (){
                    // Get.to(AppNavigationBar());
                  },
                  child: Container(
                    width: 289.w,
                    height: 52.w,
                    padding: EdgeInsets.only(left: 20.w,right: 20.w),
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
                        color: AppColors.whiteColor),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(AppImages.creditCardImg),
                        SizedBox(width: 10.w,),
                        CustomText(
                          title: "Credit Card",
                          color: AppColors.blackColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 13.85.sp,
                        ),
                        Spacer(),
                        InkWell(
                          onTap: () {
                            setState(() {
                              _value = !_value;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _value == true ? Colors.blue : Colors.grey,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: _value == true
                                  ? Icon(
                                Icons.check,
                                size: 15.0.sp,
                                color: Colors.white,
                              )
                                  : Icon(
                                Icons.check_box_outline_blank,
                                size: 15.0,
                                color: _value == true ? Colors.blue : Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 15.h),
                InkWell(
                  onTap: (){
                    // Get.to(AddressScreen());
                  },
                  child: Container(
                    padding: EdgeInsets.only(left: 20.w,right: 20.w),
                    width: 289.w,
                    height: 52.w,
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
                        color: AppColors.whiteColor),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset(AppImages.moneyCashImg),
                        SizedBox(width: 10.w,),
                        CustomText(
                          title: "Cash",
                          color: AppColors.blackColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 13.85.sp,
                        ),
                        Spacer(),
                        InkWell(
                          onTap: () {
                            setState(() {
                              _value1 = !_value1;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _value1 == true ? Colors.blue : Colors.grey,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: _value1 == true
                                  ? Icon(
                                Icons.check,
                                size: 15.0.sp,
                                color: Colors.white,
                              )
                                  : Icon(
                                Icons.check_box_outline_blank,
                                size: 15.0,
                                color: _value1 == true ? Colors.blue : Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 30.h),
                Row(
                  children: [
                    InkWell(
                      onTap: (){
                        // Get.to(AddressScreen());
                      },
                      child: Container(
                        padding: EdgeInsets.only(left: 20.w,right: 20.w),
                        width: 100.w,
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
                            color: AppColors.whiteColor),
                        child: Center(
                          child: CustomText(
                            title: "Cancel",
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
                        Get.to(const SuccessScreen());
                      },
                      child: Container(
                        // padding: EdgeInsets.only(left: 20.w,right: 20.w),
                        width: 100.w,
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
                            title: "Pay Now",
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
      },
    );
  }
}
