import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:rpm/Views/driver_dashboard/widgets/network_image_widget.dart';
import 'package:rpm/controllers/services/session_manager.dart';
import 'package:rpm/utils/app_colors.dart';
import 'package:rpm/controllers/auth/signup_controller.dart';
import 'package:rpm/Views/driver_dashboard/widgets/custom_textField.dart';
import 'package:rpm/Views/driver_dashboard/widgets/round_button.dart';
import '../../../widgets/login_button_widgets.dart';
import '../../../widgets/select_screen_widget.dart';
import '../../../../../utils/app_images.dart';
import '../Components/big_text.dart';
import '../Components/rich_text_widgets.dart';
import '../LogInScreen/login_screen.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final conPasswordController = TextEditingController();
  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  final nameFocusNode = FocusNode();
  final phoneFocusNode = FocusNode();
  final conPasswordFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  final ValueNotifier<bool> _obscurePassword = ValueNotifier<bool>(true);
  bool isLoginButtonEnabled = false;
  @override
  void initState() {
    super.initState();

    emailController.addListener(updateLoginButtonState);
    passwordController.addListener(updateLoginButtonState);
  }

  @override
  void dispose() {
    nameController.removeListener(updateLoginButtonState);
    emailController.removeListener(updateLoginButtonState);
    passwordController.removeListener(updateLoginButtonState);
    conPasswordController.removeListener(updateLoginButtonState);
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    conPasswordController.dispose();
    super.dispose();
  }

  void updateLoginButtonState() {
    setState(() {
      isLoginButtonEnabled = nameController.text.isNotEmpty &&
          emailController.text.isNotEmpty &&
          passwordController.text.isNotEmpty &&
          conPasswordController.text.isNotEmpty;
    });
  }

  final List<String> items = [
    'Driver',
    'Manager',
    'Mechanic',
  ];

  String? selectedValue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        onChanged: () {
          setState(() {
            isLoginButtonEnabled = nameController.text.isNotEmpty &&
                emailController.text.isNotEmpty &&
                passwordController.text.isNotEmpty &&
                conPasswordController.text.isNotEmpty;
          });
        },
        child: Padding(
          padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 80.h),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ImagePickerWidget(),
                SizedBox(height: 10),
                CustomText(
                    title: "New Here?",
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.w400,
                    fontSize: 22.sp),
                SizedBox(
                  height: 15.h,
                ),
                CustomText(
                    title: "Create an account to Continue",
                    color: AppColors.grayText2,
                    fontWeight: FontWeight.w400,
                    fontSize: 14.sp),
                SizedBox(
                  height: 44.h,
                ),
                CustomTextField(
                  readOnly: false,
                  controller: nameController,
                  focusNode: nameFocusNode,
                  onFieldSubmittedValue: (newValue) {},
                  keyBoardType: TextInputType.emailAddress,
                  obscureText: false,
                  prefixIcon: Icon(Icons.person_outline,
                      color: AppColors.textFieldBorderColor),
                  hint: 'Name',
                  onChange: (value) {},
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your Name";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                CustomTextField(
                  readOnly: false,
                  controller: phoneController,
                  focusNode: phoneFocusNode,
                  onFieldSubmittedValue: (newValue) {},
                  keyBoardType: TextInputType.emailAddress,
                  obscureText: false,
                  prefixIcon: Icon(Icons.person_outline,
                      color: AppColors.textFieldBorderColor),
                  hint: 'Phone',
                  onChange: (value) {},
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your Phone";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 10.h,
                ),
                CustomTextField(
                  readOnly: false,
                  controller: emailController,
                  focusNode: emailFocusNode,
                  onFieldSubmittedValue: (newValue) {},
                  keyBoardType: TextInputType.emailAddress,
                  obscureText: false,
                  prefixIcon: Icon(Icons.email_outlined,
                      color: AppColors.textFieldBorderColor),
                  hint: 'Email',
                  onChange: (value) {},
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        !GetUtils.isEmail(value)) {
                      return "Please enter a valid email";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 10.h,
                ),
                CustomTextField(
                  readOnly: false,
                  maxLines: 1,
                  controller: passwordController,
                  focusNode: passwordFocusNode,
                  onFieldSubmittedValue: (newValue) {},
                  onChange: (value) {},
                  prefixIcon: Icon(
                    Icons.lock_open_outlined,
                    color: AppColors.textFieldBorderColor,
                  ),
                  keyBoardType: TextInputType.text,
                  obscureText: _obscurePassword.value,
                  hint: 'Password',
                  validator: (value) {
                    if (value == null || value.isEmpty || value.length < 6) {
                      return "Password must be at least 6 characters";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 10.h,
                ),
                CustomTextField(
                  readOnly: false,
                  controller: conPasswordController,
                  focusNode: conPasswordFocusNode,
                  onFieldSubmittedValue: (newValue) {},
                  keyBoardType: TextInputType.visiblePassword,
                  obscureText: true,
                  maxLines: 1,
                  prefixIcon: Icon(Icons.lock_open_rounded,
                      color: AppColors.textFieldBorderColor),
                  hint: 'Confirm Password',
                  onChange: (value) {},
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your password";
                    }
                    if (value != passwordController.text) {
                      return "Passwords do not match";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 10.h,
                ),
                InkWell(
                  onTap: () {
                    if (selectedValue == null || selectedValue!.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Please select your role'),
                        ),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                LoginScreen()), // Replace with the desired screen
                      );
                    }
                  },
                  child: Container(
                    height: 50.0,
                    width: double.infinity,
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(
                        color: AppColors
                            .textFieldBorderColor, // Customize the border color
                        width: 1.5,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        DropdownButtonHideUnderline(
                          child: DropdownButton2<String>(
                            isExpanded: true,
                            hint: Row(
                              children: [
                                Text(
                                  'Select Your Role',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.textFieldTextColor,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                            underline: Divider(
                              height: 4,
                              color: Colors.red,
                            ),
                            items: items
                                .map((String item) => DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(
                                        item,
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.blackColor,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ))
                                .toList(),
                            value: selectedValue,
                            onChanged: (String? value) {
                              setState(() {
                                selectedValue = value;
                              });
                            },
                            buttonStyleData: ButtonStyleData(
                              height: 40.h,
                              width: 290.w,
                              // elevation: 2,
                            ),
                            iconStyleData: IconStyleData(
                              icon: Icon(
                                Icons.keyboard_arrow_down,
                              ),
                              iconSize: 18.sp,
                              iconEnabledColor: AppColors.textFieldBorderColor,
                              iconDisabledColor: Colors.grey,
                            ),
                            dropdownStyleData: DropdownStyleData(
                              maxHeight: 200,
                              width: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                color: Color(0xffF9F9F9),
                              ),
                              scrollbarTheme: ScrollbarThemeData(
                                radius: const Radius.circular(40),
                                thickness: MaterialStateProperty.all<double>(6),
                                thumbVisibility:
                                    MaterialStateProperty.all<bool>(true),
                              ),
                            ),
                            menuItemStyleData: const MenuItemStyleData(
                              height: 40,
                              padding: EdgeInsets.only(left: 14, right: 14),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 29.h,
                ),
                Consumer<SignupController>(
                  builder: (context, value, child) => SizedBox(
                    width: 260,
                    child: RoundButton(
                        title: 'Signup',
                        loading: value.loading,
                        onPress: () {
                          // isLoginButtonEnabled
                          //     ? () {
                          if (_formKey.currentState!.validate()) {
                            value.signUpUser(
                              context,
                              nameController.text.trim(),
                              emailController.text.trim(),
                              passwordController.text.trim(),
                              selectedValue.toString(),
                              phoneController.text.trim().toString(),
                            );
                            // Navigate to the LoginScreen
                          }
                          //   }
                          // : null;
                        }),
                  ),
                  // ElevatedButton(
                  //   onPressed: isLoginButtonEnabled
                  //       ? () {
                  //           if (_formKey.currentState!.validate()) {
                  //             value.signUpUser(
                  //                 context,
                  //                 nameController.text.trim(),
                  //                 emailController.text.trim(),
                  //                 passwordController.text.trim(),
                  //                 selectedValue.toString());
                  //             // Navigate to the LoginScreen
                  //           }
                  //         }
                  //       : null,
                  //   style: ElevatedButton.styleFrom(
                  //     backgroundColor: AppColors.textFieldBorderColor,
                  //     fixedSize: Size(154.w, 50.h),
                  //     shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(10.0),
                  //     ),
                  //   ),
                  //   child: CustomText(
                  //     title: "SignUp",
                  //     fontSize: 18.sp,
                  //     fontWeight: FontWeight.w400,
                  //     color: AppColors.whiteColor,
                  //   ),
                  // ),
                ),
                // SizedBox(
                //   height: 50.h,
                // ),
                // CustomText(
                //     title: "or continue with",
                //     color: AppColors.blackColor.withOpacity(0.70),
                //     fontWeight: FontWeight.w400,
                //     fontSize: 14.sp),
                // SizedBox(
                //   height: 25.h,
                // ),
                // Row(
                //   crossAxisAlignment: CrossAxisAlignment.center,
                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //   children: [
                //     Image.asset(
                //       AppImages.fbImg,
                //       width: 30.w,
                //       height: 30.h,
                //     ),
                //     // SizedBox(width: 54.h,),
                //     Image.asset(
                //       AppImages.instImg,
                //       width: 30.w,
                //       height: 30.h,
                //     ),
                //     // SizedBox(width: 54.h,),
                //     Image.asset(
                //       AppImages.googleImg,
                //       width: 30.w,
                //       height: 30.h,
                //     ),
                //   ],
                // ),
                SizedBox(height: 40.h),
                RichTextWidgets(
                  title: 'Already have an Account? ',
                  text: 'Sign In',
                  onPressed: () {
                    Get.to(LoginScreen());
                  },
                ),
                SizedBox(
                  height: 30.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProfilePickImageDailog extends StatelessWidget {
  const ProfilePickImageDailog({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 120,
        child: Consumer<SignupController>(
          builder: (context, value, child) => Column(
            children: [
              ListTile(
                tileColor: AppColors.textFieldBorderColor,
                onTap: () {
                  value.pickImage(context, ImageSource.camera);
                  Navigator.pop(context);
                },
                leading: Icon(
                  Icons.camera,
                  color: AppColors.primaryText,
                ),
                title: const Text('Camera'),
              ),
              ListTile(
                tileColor: AppColors.textFieldBorderColor,
                onTap: () {
                  value.pickImage(context, ImageSource.gallery);
                  Navigator.pop(context);
                },
                leading: Icon(
                  Icons.image,
                  color: AppColors.primaryText,
                ),
                title: const Text('Gallery'),
              )
            ],
          ),
        ));
  }
}

// class SignupProfilePictureWidget extends StatelessWidget {
//   final dynamic snapshot;
//   final String userProfileUid;
//   const SignupProfilePictureWidget({
//     super.key,
//     required this.snapshot,
//     required this.userProfileUid,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<SignupController>(
//         builder: (context, provider, child) => SizedBox(
//               width: 84,
//               height: 76,
//               child: Stack(
//                 children: [
//                   Align(
//                     alignment: Alignment.topLeft,
//                     child: Container(
//                       height: 80,
//                       width: 80,
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(50),
//                           // shape: BoxShape.circle,
//                           border: Border.all(
//                             color: snapshot.data!.docs[0]['profileImage']
//                                         .toString() ==
//                                     ""
//                                 ? AppColors.textFieldBorderColor
//                                 : Colors.transparent,
//                           )),
//                       child: provider.image == null
//                           ? snapshot.data!.docs[0]['profileImage'].toString() ==
//                                   ""
//                               ? Icon(
//                                   Icons.person,
//                                   size: 35,
//                                   color: Theme.of(context)
//                                       .colorScheme
//                                       .onBackground,
//                                 )
//                               : NetworkImageWidget(
//                                   borderRadius: 50,
//                                   imageUrl: snapshot
//                                       .data!.docs[0]['profileImage']
//                                       .toString())
//                           : Image.file(File(provider.image!.path).absolute),
//                     ),
//                   ),
//                   userProfileUid == SessionController().userId
//                       ? Positioned(
//                           bottom: 5,
//                           right: 5,
//                           child: Container(
//                               decoration: BoxDecoration(
//                                   color: Colors.red, shape: BoxShape.circle),
//                               child: GestureDetector(
//                                   onTap: () {
//                                     showDialog(
//                                         context: context,
//                                         builder: (BuildContext context) {
//                                           return const AlertDialog(
//                                               content:
//                                                   ProfilePickImageDailog());
//                                         });
//                                   },
//                                   child: Icon(Icons.add_circle_outline))),
//                         )
//                       : const SizedBox.shrink(),
//                 ],
//               ),
//             ));
//   }
// }
class ImagePickerWidget extends StatelessWidget {
  const ImagePickerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<SignupController>(
        builder: (context, value, child) => Stack(
              alignment: Alignment.bottomRight,
              children: [
                if (value.image != null)
                  Container(
                    width: 150, // Adjust size as needed
                    height: 150, // Adjust size as needed
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey[300],
                    ),
                    child: Image.file(
                      File(value.image!.path).absolute,
                      fit: BoxFit.cover,
                    ),
                  ),
                if (value.image == null)
                  Container(
                    width: 150, // Adjust size as needed
                    height: 150, // Adjust size as needed
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey[300],
                    ),
                    child: Center(
                      child: Icon(Icons.person, size: 100, color: Colors.grey),
                    ),
                  ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: IconButton(
                    icon: Icon(Icons.add_a_photo),
                    onPressed: () {
                      // Add functionality for picking an image
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                                backgroundColor: AppColors.textFieldBorderColor,
                                content: ProfilePickImageDailog());
                          });
                    },
                  ),
                ),
              ],
            ));
  }
}
