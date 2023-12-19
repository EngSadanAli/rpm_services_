import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../ShopPart/Auth/Components/big_text.dart';
import '../../../../utils/app_colors.dart';
class AccountSettingScreen extends StatelessWidget {
   AccountSettingScreen({super.key});
  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final emailController = TextEditingController();
  final companyController = TextEditingController();
  final managerController = TextEditingController();
  final unitController = TextEditingController();
  final passwordController = TextEditingController();
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
          title: "Account ",
          fontWeight: FontWeight.w700,
          fontSize: 18.sp,
          color: AppColors.blackColor.withOpacity(.87),
        ),
        actions: [
          IconButton(onPressed: (){},
            icon: Icon(Icons.edit,
              color: AppColors.blackColor,),
          )
        ],
      ),
      body: Padding(
        padding:  EdgeInsets.only(left: 16.sp,right: 16.sp,top: 10.h),
        child: Padding(
          padding:  EdgeInsets.only(left: 10.w,right: 10.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
       title: "Account Details",
             fontSize: 18.sp,
             fontWeight: FontWeight.w700,
             color: AppColors.blackColor,
               ),
                SizedBox(height: 12.h,),
                CustomText(title: "Name",
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.blackColor.withOpacity(.38),
                ),
                SizedBox(height: 6.h,),
                TextField(
                  style: TextStyle(
                      color: AppColors.blackColor
                  ),
                  controller: nameController,
                  decoration: InputDecoration(
                      labelText: 'Name',
                      contentPadding:  EdgeInsets.all(10.r),
                      // border: InputBorder.none,
                  ),
                ),
                SizedBox(height: 6.h,),
                CustomText(title: "Address",
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.blackColor.withOpacity(.38),
                ),
                SizedBox(height: 6.h,),
                TextField(
                  style: TextStyle(
                      color: AppColors.blackColor
                  ),
                  controller: addressController,
                  decoration: InputDecoration(
                      labelText: 'Address',
                      contentPadding: const EdgeInsets.all(10),
                      // border: InputBorder.none,
                  ),
                ),
                SizedBox(height: 6.h,),
                CustomText(title: "Email Address",
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.blackColor.withOpacity(.38),
                ),
                SizedBox(height: 6.h,),
                TextField(
                  style: TextStyle(
                      color: AppColors.blackColor
                  ),
                  controller: emailController,
                  decoration: InputDecoration(
                      labelText: 'Email Address',
                      contentPadding: const EdgeInsets.all(10),
                      // border: InputBorder,
                  ),
                ),
                SizedBox(height: 6.h,),
                CustomText(title: "Company Name",
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.blackColor.withOpacity(.38),
                ),
                SizedBox(height: 6.h,),
                TextField(
                  style: TextStyle(
                      color: AppColors.blackColor
                  ),
                  controller: companyController,
                  decoration: InputDecoration(
                    labelText: 'Company Name',
                    contentPadding:  EdgeInsets.all(10.r),
                    // border: InputBorder,
                  ),
                ),
                SizedBox(height: 6.h,),
                CustomText(title: "Manager Name",
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.blackColor.withOpacity(.38),
                ),
                SizedBox(height: 6.h,),
                TextField(
                  style: TextStyle(
                      color: AppColors.blackColor
                  ),
                  controller: managerController,
                  decoration: InputDecoration(
                    labelText: 'Manager Name',
                    contentPadding:  EdgeInsets.all(10.r),
                    // border: InputBorder,
                  ),
                ),
                SizedBox(height: 6.h,),
                CustomText(title: "Unit Number",
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.blackColor.withOpacity(.38),
                ),
                SizedBox(height: 6.h,),
                TextField(
                  style: TextStyle(
                      color: AppColors.blackColor
                  ),
                  controller: unitController,
                  decoration: InputDecoration(
                    labelText: 'Unit Number',
                    contentPadding:  EdgeInsets.all(10.r),
                    // border: InputBorder,
                  ),
                ),
                SizedBox(height: 10.h,),
                CustomText(
                  title: "Account Security",
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.blackColor,
                ),
                SizedBox(height: 6.h,),
                CustomText(title: "Password",
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.blackColor.withOpacity(.38),
                ),
                SizedBox(height: 6.h,),
                TextField(
                  style: TextStyle(
                      color: AppColors.blackColor
                  ),
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    contentPadding:  EdgeInsets.all(10.r),
                    // border: InputBorder,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
