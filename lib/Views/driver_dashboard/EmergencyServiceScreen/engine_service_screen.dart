import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:rpm/Views/driver_dashboard/EmergencyServiceScreen/MechanicsProfile/mechanics_profile_screen.dart';
import 'package:rpm/Views/driver_dashboard/ScheduleServiceScreen/widget/schedule_row_widget.dart';
import 'package:rpm/Views/driver_dashboard/widgets/round_button.dart';
import 'package:rpm/config/app_config.dart';
import 'package:rpm/controllers/driver/order/service_req/emer_service_controller.dart';
import 'package:rpm/controllers/driver/order/service_req/schedule_service_controller.dart';
import 'package:rpm/controllers/services/session_manager.dart';
import 'package:rpm/utils/utils.dart';
import '../widgets/custom_textField.dart';
import '../ScheduleServiceScreen/set_date_and_time_schedule.dart';
import '../SelectDataAndTimeScreen/select_date_time_screen.dart';
import '../ShopPart/Auth/Components/big_text.dart';
import '../../../utils/app_colors.dart';
import 'Widgets/emergency_row_widget.dart';

class EngineServiceScreen extends StatefulWidget {
  final bool showBackButton;
  EngineServiceScreen({super.key, required this.showBackButton});

  @override
  State<EngineServiceScreen> createState() => _EngineServiceScreenState();
}

class _EngineServiceScreenState extends State<EngineServiceScreen> {
  final vinController = TextEditingController();
  final currentMileageController = TextEditingController();
  final engineHoursController = TextEditingController();
  final conplaintController = TextEditingController();
  final AdditionalconplaintController = TextEditingController();
  final additionalconplaintFocusNode = FocusNode();
  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  final nameFocusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text('Emergency service'),
            leading: widget.showBackButton
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
          body: Consumer<EmergencyServiceController>(
            builder: (context, value, child) => Padding(
              padding: EdgeInsets.only(left: 15.w, right: 15, top: 10.h),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
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
                                    SizedBox(
                                      height: 6.h,
                                    ),
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
                          if (value == null || value.isEmpty) {
                            return 'Please enter VIN';
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
                          if (value == null || value.isEmpty) {
                            return 'Please enter Current Mileage';
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
                          if (value == null || value.isEmpty) {
                            return 'Please enter Engine Hours';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Container(
                        height: 160.h,
                        decoration: BoxDecoration(
                            color: AppColors.whiteColor,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: AppColors.textFieldBorderColor,
                                width: 1.5.w)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFormField(
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
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a Complaint';
                                }
                                return null;
                              },
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
                        height: 10.h,
                      ),
                      CustomTextField(
                        readOnly: false,
                        controller: AdditionalconplaintController,
                        focusNode: additionalconplaintFocusNode,
                        onFieldSubmittedValue: (newValue) {},
                        keyBoardType: TextInputType.text,
                        obscureText: false,
                        hint: 'Additional Complaint',
                        onChange: (value) {},
                        // validator: (value) {
                        //   if (value == null || value.isEmpty) {
                        //     return 'Please enter Additional Complaint';
                        //   }
                        //   return null;
                        // },
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Container(
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: Text('Pick location'),
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
                      //             color:
                      //                 Colors.black.withOpacity(0.50), // Shadow color
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
                      // GestureDetector(
                      //   onTap: () {
                      //     // Get.to(SelectDateAndTime(title: "date time",));
                      //   },
                      //   child: Container(
                      //     width: double.infinity,
                      //     height: 50,
                      //     decoration: BoxDecoration(
                      //         boxShadow: [
                      //           BoxShadow(
                      //             color:
                      //                 Colors.black.withOpacity(0.50), // Shadow color
                      //             spreadRadius: 0,
                      //             blurRadius: 4,
                      //             offset: Offset(1, 2), // Offset in x and y direction
                      //           ),
                      //         ],
                      //         borderRadius: BorderRadius.circular(10),
                      //         color: Color(0xffF3F5F7)),
                      //     child: Center(
                      //       child: Text('Dispatch Emergency Service',
                      //           style: TextStyle(
                      //               fontSize: 14.sp,
                      //               fontWeight: FontWeight.w400,
                      //               color: AppColors.textFieldBorderColor)),
                      //     ),
                      //   ),
                      // ),
                      SizedBox(
                        height: 10.h,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 3,
                            child: RoundButton(
                              loading: value.loading,
                              title: 'Next',
                              onPress: () {
                                if (_formKey.currentState!.validate()) {
                                  if (value.imageFile != null) {
                                    value
                                        .emergencyService(
                                      context,
                                      vinController.text.trim(),
                                      currentMileageController.text.trim(),
                                      engineHoursController.text.trim(),
                                      conplaintController.text.trim(),
                                      AdditionalconplaintController.text.trim(),
                                    )
                                        .then((value) {
                                      currentMileageController.clear();
                                      vinController.clear();
                                      conplaintController.clear();
                                      engineHoursController.clear();
                                      AdditionalconplaintController.clear();
                                    });
                                  } else {
                                    Utils.flushBarErrorMessage(
                                        'Please Attached a image',
                                        BuildContext,
                                        context);
                                  }
                                }
                              },
                            ),
                          ),
                          // GestureDetector(
                          //   onTap: () {
                          //     // if (_formKey.currentState!.validate()) {
                          //     //   value
                          //     //       .emergencyService(
                          //     //     context,
                          //     //     vinController.text.trim(),
                          //     //     currentMileageController.text.trim(),
                          //     //     engineHoursController.text.trim(),
                          //     //     conplaintController.text.trim(),
                          //     //   )
                          //     //       .then((value) {
                          //     //     currentMileageController.clear();
                          //     //     vinController.clear();
                          //     //     conplaintController.clear();
                          //     //     engineHoursController.clear();
                          //     //   });
                          //     // }

                          //     // Get.to(MechanicsProfileScreen());
                          //   },
                          //   child: Container(
                          //     // padding: EdgeInsets.only(left: 20.w,right: 20.w),
                          //     width: 140.w,
                          //     height: 38.w,
                          //     decoration: BoxDecoration(
                          //         boxShadow: [
                          //           BoxShadow(
                          //             color: Colors.grey
                          //                 .withOpacity(0.35), // Shadow color
                          //             spreadRadius: 2,
                          //             blurRadius: 5,
                          //             offset: Offset(
                          //                 1, 3), // Offset in x and y direction
                          //           ),
                          //         ],
                          //         borderRadius: BorderRadius.circular(10.r),
                          //         color: AppColors.textFieldBorderColor),
                          //     child: Center(
                          //       child: CustomText(
                          //         title: "Next",
                          //         color: AppColors.whiteColor,
                          //         fontWeight: FontWeight.w400,
                          //         fontSize: 13.85.sp,
                          //       ),
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
