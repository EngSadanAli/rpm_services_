import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rpm/Views/EmergencyServiceScreen/MechanicsProfile/mechanics_profile_screen.dart';
import '../../widgets/custom_textField.dart';
import '../ScheduleServiceScreen/set_date_and_time_schedule.dart';
import '../SelectDataAndTimeScreen/select_date_time_screen.dart';
import '../ShopPart/Auth/Components/big_text.dart';
import '../Utils/app_colors.dart';
import 'Widgets/emergency_row_widget.dart';

class EngineServiceScreen  extends StatefulWidget {
   EngineServiceScreen ({super.key});

  @override
  State<EngineServiceScreen> createState() => _EngineServiceScreenState();
}

class _EngineServiceScreenState extends State<EngineServiceScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _textEditingController = TextEditingController();
   final emailFocusNode = FocusNode();
   final passwordFocusNode = FocusNode();
   final nameFocusNode = FocusNode();
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
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: CustomText(
          title: "Emergency service ",
          fontWeight: FontWeight.w400,
          fontSize: 18.sp,
          color: AppColors.whiteColor,
        ),
      ),
      body: Padding(
        padding:  EdgeInsets.only(left: 15.w,right: 15,top: 10.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(title: "Driver Details",
                  fontWeight: FontWeight.w400,
                    fontSize: 14.sp,
                    color: AppColors.blackColor.withOpacity(.50),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      EmergencyRow(
                        title: "Name: ",
                        text: "John",
                      ),
                      SizedBox(height: 6.h,),
                      EmergencyRow(
                        title: "Manager  Name:",
                        text: "Mr.Philips",
                      ),
                      SizedBox(height: 6.h,),
                      EmergencyRow(
                        title: "Unit Number: ",
                        text: " 914",
                      ),
                      SizedBox(height: 6.h,),
                      EmergencyRow(
                        title: "C Name: ",
                        text: "Al-Asfa Car ",
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(height: 20.h,),
              CustomTextField(
                readOnly: false,
                controller: nameController,
                focusNode: nameFocusNode,
                onFieldSubmittedValue: (newValue) {},
                keyBoardType: TextInputType.emailAddress,
                obscureText: false,
                hint: 'VIN #',
                onChange: (value) {},
                validator: (value) {
                  if (!GetUtils.isEmail(value!)) {
                    return "Please enter Your VIN";
                  }
                  return null;
                },
              ),
              SizedBox(height: 10.h,),
              CustomTextField(
                readOnly: false,
                controller: emailController,
                focusNode: emailFocusNode,
                onFieldSubmittedValue: (newValue) {},
                keyBoardType: TextInputType.emailAddress,
                obscureText: false,
                hint: 'Current Mileage',
                onChange: (value) {},
                validator: (value) {
                  if (!GetUtils.isEmail(value!)) {
                    return "Please enter Your Current Mileage";
                  }
                  return null;
                },
              ),
              SizedBox(height: 10.h,),
              CustomTextField(
                readOnly: false,
                controller: passwordController,
                focusNode: passwordFocusNode,
                onFieldSubmittedValue: (newValue) {},
                keyBoardType: TextInputType.emailAddress,
                obscureText: false,
                hint: 'Engine Hours',
                onChange: (value) {},
                validator: (value) {
                  if (!GetUtils.isEmail(value!)) {
                    return "Please enter Your Engine Hours";
                  }
                  return null;
                },
              ),
              SizedBox(height: 10.h,),
              Container(
                height: 150.h,
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.textFieldBorderColor,width: 1.5.w)
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      style: TextStyle(
                        color: Colors.black
                      ),
                      controller: _textEditingController,
                      decoration: InputDecoration(
                        labelText: 'Complaint 1',
                        contentPadding: const EdgeInsets.all(10),
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.person_outline,color: AppColors.textFieldBorderColor,)
                      ),
                    ),
                    Padding(
                      padding:  EdgeInsets.only(left: 20.w,top: 20.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          CustomText(title: "Add Image/Video",
                            fontWeight: FontWeight.w400,
                            fontSize: 10.sp,
                            color: AppColors.blackColor,
                          ),
                          SizedBox(height: 6.h,),
                          Row(
                            children: [
                              Container(height: 50.h,
                                width: 78.w,
                              decoration: BoxDecoration(
                                color: AppColors.whiteColor,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.16), // Shadow color
                                    spreadRadius: 0,
                                    blurRadius: 4,
                                    offset: Offset(1, 3), // Offset in x and y direction
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(6.r),
                              ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(Icons.camera_alt_outlined,color: Colors.red,),
                                    SizedBox(height: 2.h,),
                                    CustomText(title: "Take Picture",
                                      fontWeight: FontWeight.w400,
                                      fontSize: 10.sp,
                                      color: AppColors.blackColor,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 10.w,),
                              Container(
                                  height: 50.h,
                                width: 78.w,
                              decoration: BoxDecoration(
                                color: AppColors.whiteColor,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.16), // Shadow color
                                    spreadRadius: 0,
                                    blurRadius: 4,
                                    offset: Offset(1, 3), // Offset in x and y direction
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(6.r),
                              ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(Icons.photo_camera_back_outlined,color: Colors.red,),
                                    SizedBox(height: 2.h,),
                                    CustomText(title: "Add Video",
                                      fontWeight: FontWeight.w400,
                                      fontSize: 10.sp,
                                      color: AppColors.blackColor,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.h,),
              GestureDetector(
                onTap: (){
                },
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.50), // Shadow color
                          spreadRadius: 0,
                          blurRadius: 4,
                          offset: Offset(1, 2), // Offset in x and y direction
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xffF3F5F7)),
                  child: Center(
                    child: Text('Add Additional Complaint',
                        style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.textFieldBorderColor)),
                  ),
                ),
              ),
              SizedBox(height: 15.h,),
              GestureDetector(
                onTap: (){
                  // Get.to(SelectDateAndTime(title: "date time",));
                },
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.50), // Shadow color
                          spreadRadius: 0,
                          blurRadius: 4,
                          offset: Offset(1, 2), // Offset in x and y direction
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xffF3F5F7)),
                  child: Center(
                    child: Text('Dispatch Emergency Service',
                        style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.textFieldBorderColor)),
                  ),
                ),
              ),
              SizedBox(height: 10.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: (){
                      Get.to(MechanicsProfileScreen());
                    },
                    child: Container(
                      // padding: EdgeInsets.only(left: 20.w,right: 20.w),
                      width: 140.w,
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
                          title: "Next",
                          color: AppColors.whiteColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 13.85.sp,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h,),
            ],
          ),
        ),
      ),
    );
  }
}
