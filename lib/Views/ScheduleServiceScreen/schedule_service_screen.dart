import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:rpm/Views/ScheduleServiceScreen/set_date_and_time_schedule.dart';
import 'package:rpm/Views/ScheduleServiceScreen/widget/schedule_row_widget.dart';
import 'package:rpm/config/app_config.dart';
import 'package:rpm/controllers/service_req/schedule_service_controller.dart';
import 'package:rpm/controllers/services/session_manager.dart';
import '../../widgets/custom_textField.dart';
import '../ShopPart/Auth/Components/big_text.dart';
import '../Utils/app_colors.dart';

class ScheduleServiceScreen extends StatefulWidget {
  const ScheduleServiceScreen({super.key});

  @override
  State<ScheduleServiceScreen> createState() => _ScheduleServiceScreenState();
}

class _ScheduleServiceScreenState extends State<ScheduleServiceScreen> {
  final vinController = TextEditingController();
  final currentMileageController = TextEditingController();
  final engineHoursController = TextEditingController();
  final conplaintController = TextEditingController();
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
          title: "Schedule service ",
          fontWeight: FontWeight.w400,
          fontSize: 18.sp,
          color: AppColors.whiteColor,
        ),
      ),
      body: Consumer<ScheduleServiceController>(
          builder: (context, value, child) => Padding(
                padding: EdgeInsets.only(left: 15.w, right: 15, top: 10.h),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            title: "Driver Details",
                            fontWeight: FontWeight.w400,
                            fontSize: 14.sp,
                            color: AppColors.blackColor.withOpacity(.50),
                          ),
                          FutureBuilder<DocumentSnapshot>(
                            future: FirebaseFirestore.instance
                                .collection('users')
                                .doc(SessionController().userId)
                                .get(),
                            builder: (BuildContext context,
                                AsyncSnapshot<DocumentSnapshot> snapshot) {
                              if (snapshot.hasError) {
                                return Text("Something went wrong");
                              }

                              if (snapshot.hasData && !snapshot.data!.exists) {
                                return Text("Document does not exist");
                              }

                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                Map<String, dynamic> data = snapshot.data!
                                    .data() as Map<String, dynamic>;
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ScheduleRow(
                                      title: "Name: ",
                                      text: SessionController().name.toString(),
                                    ),
                                    SizedBox(
                                      height: 6.h,
                                    ),
                                    ScheduleRow(
                                      title: "Email:",
                                      text: data['email'],
                                    ),

                                    // SizedBox(
                                    //   height: 6.h,
                                    // ),
                                    // ScheduleRow(
                                    //   title: "Unit Number: ",
                                    //   text: data['unitNumber'],
                                    // ),
                                    // SizedBox(
                                    //   height: 6.h,
                                    // ),
                                    // ScheduleRow(
                                    //   title: "C Name: ",
                                    //   text: data['cName'],
                                    // ),
                                  ],
                                );
                              }

                              return Text("loading");
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      CustomTextField(
                        readOnly: false,
                        controller: vinController,
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
                      SizedBox(
                        height: 10.h,
                      ),
                      CustomTextField(
                        readOnly: false,
                        controller: currentMileageController,
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
                      SizedBox(
                        height: 10.h,
                      ),
                      CustomTextField(
                        readOnly: false,
                        controller: engineHoursController,
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
                      SizedBox(
                        height: 10.h,
                      ),
                      Container(
                        height: 150.h,
                        decoration: BoxDecoration(
                            color: AppColors.whiteColor,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: AppColors.textFieldBorderColor,
                                width: 1.5.w)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextField(
                              style: TextStyle(color: Colors.black),
                              controller: conplaintController,
                              decoration: InputDecoration(
                                  labelText: 'Complaint 1',
                                  contentPadding: const EdgeInsets.all(10),
                                  border: InputBorder.none,
                                  prefixIcon: Icon(
                                    Icons.person_outline,
                                    color: AppColors.textFieldBorderColor,
                                  )),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 20.w, top: 20.h),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    title: "Add Image/Video",
                                    fontWeight: FontWeight.w400,
                                    fontSize: 10.sp,
                                    color: AppColors.blackColor,
                                  ),
                                  SizedBox(
                                    height: 6.h,
                                  ),
                                  Row(
                                    children: [
                                      InkWell(
                                        onTap: () => value.pickImage(
                                            context, ImageSource.camera),
                                        child: Container(
                                          height: 50.h,
                                          width: 78.w,
                                          decoration: BoxDecoration(
                                            color: AppColors.whiteColor,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black.withOpacity(
                                                    0.16), // Shadow color
                                                spreadRadius: 0,
                                                blurRadius: 4,
                                                offset: Offset(1,
                                                    3), // Offset in x and y direction
                                              ),
                                            ],
                                            borderRadius:
                                                BorderRadius.circular(6.r),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              if (value.imageFile != null)
                                                Stack(children: [
                                                  Container(
                                                    height: 50.h,
                                                    width: 78.w,
                                                    decoration: BoxDecoration(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .onPrimary,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              13),
                                                      image: DecorationImage(
                                                        image: FileImage(
                                                            value.imageFile!),
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                      bottom: 2,
                                                      right: 2,
                                                      child: InkWell(
                                                        onTap: () {
                                                          value.pickImage(
                                                              context,
                                                              ImageSource
                                                                  .camera);
                                                        },
                                                        child: Container(
                                                            height: 20,
                                                            width: 20,
                                                            decoration: BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                                color: AppColors
                                                                    .redTextColor),
                                                            child: Icon(
                                                              Icons.add,
                                                              color:
                                                                  Colors.white,
                                                            )),
                                                      ))
                                                ]),
                                              if (value.imageFile == null)
                                                Icon(
                                                  Icons.camera_alt_outlined,
                                                  color: Colors.red,
                                                ),
                                              if (value.imageFile == null)
                                                SizedBox(
                                                  height: 2.h,
                                                ),
                                              if (value.imageFile == null)
                                                CustomText(
                                                  title: "Take Picture",
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 10.sp,
                                                  color: AppColors.blackColor,
                                                ),
                                            ],
                                          ),
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
                      SizedBox(
                        height: 16.h,
                      ),
                      // GestureDetector(
                      //   onTap: () {},
                      //   child: Container(
                      //     width: double.infinity,
                      //     height: 50,
                      //     decoration: BoxDecoration(
                      //         boxShadow: [
                      //           BoxShadow(
                      //             color: Colors.black.withOpacity(0.50), // Shadow color
                      //             spreadRadius: 0,
                      //             blurRadius: 4,
                      //             offset: Offset(1, 2), // Offset in x and y direction
                      //           ),
                      //         ],
                      //         borderRadius: BorderRadius.circular(10),
                      //         color: Color(0xffF3F5F7)),
                      //     child: Center(
                      //       child: Text('Add Additional Complaint',
                      //           style: TextStyle(
                      //               fontSize: 14.sp,
                      //               fontWeight: FontWeight.w400,
                      //               color: AppColors.textFieldBorderColor)),
                      //     ),
                      //   ),
                      // ),
                      // SizedBox(
                      //   height: 15.h,
                      // ),
                      GestureDetector(
                        onTap: () {
                          Get.to(SelectDateAndTime(
                              title: 'Date Time',
                              vin: vinController.text.trim(),
                              currentMileage:
                                  currentMileageController.text.trim(),
                              engineHours: engineHoursController.text.trim(),
                              complaint: conplaintController.text.trim()));
                        },
                        child: Container(
                          width: double.infinity,
                          height: 50,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black
                                      .withOpacity(0.50), // Shadow color
                                  spreadRadius: 0,
                                  blurRadius: 4,
                                  offset: Offset(
                                      1, 2), // Offset in x and y direction
                                ),
                              ],
                              borderRadius: BorderRadius.circular(10),
                              color: AppColors.textFieldBorderColor),
                          child: Center(
                            child: Text('Select Service Date',
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.whiteColor)),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                    ],
                  ),
                ),
              )),
    );
  }
}
