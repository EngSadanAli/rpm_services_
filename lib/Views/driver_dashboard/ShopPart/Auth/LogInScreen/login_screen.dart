import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:rpm/Views/driver_dashboard/ShopPart/Auth/forgot_password_screen/forgot.dart';
import 'package:rpm/utils/app_colors.dart';
import 'package:rpm/controllers/auth/login_controller.dart';
import 'package:rpm/Views/driver_dashboard/widgets/custom_textField.dart';
import 'package:rpm/Views/driver_dashboard/widgets/round_button.dart';
import 'package:rpm/Views/driver_dashboard/widgets/select_screen_widget.dart';
import '../../../widgets/login_button_widgets.dart';
import '../../../../../utils/app_images.dart';
import '../Components/big_text.dart';
import '../Components/rich_text_widgets.dart';
import '../SignUpScreen/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
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
    // Clean up the controllers to avoid memory leaks
    emailController.removeListener(updateLoginButtonState);
    passwordController.removeListener(updateLoginButtonState);
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void updateLoginButtonState() {
    setState(() {
      isLoginButtonEnabled =
          emailController.text.isNotEmpty && passwordController.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Form(
              key: _formKey,
              onChanged: () {
                setState(() {
                  isLoginButtonEnabled = emailController.text.isNotEmpty &&
                      passwordController.text.isNotEmpty;
                });
              },
              child: Padding(
                padding: EdgeInsets.only(
                  left: 20.w,
                  right: 20.w,
                ),
                child: Consumer<LoginController>(
                  builder: (context, value, child) => Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(AppImages.appLogo, height: 130.h
                          // width: 231.w,
                          ),
                      SizedBox(height: 10.h),
                      CustomText(
                          title: "Welcome",
                          color: AppColors.blackColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 22.sp),
                      // SizedBox(height: 10.h),
                      // CustomText(
                      //   title: "Welcome back! You have been",
                      //   color: AppColors.grayText2,
                      //   fontWeight: FontWeight.w400,
                      //   fontSize: 14.sp,
                      // ),
                      // Center(
                      //   child: CustomText(
                      //     title: "missed",
                      //     color: AppColors.grayText2,
                      //     fontWeight: FontWeight.w400,
                      //     fontSize: 14.sp,
                      //   ),
                      // ),
                      SizedBox(height: 30.h),
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
                          Icons.lock_open_rounded,
                          color: AppColors.textFieldBorderColor,
                        ),
                        keyBoardType: TextInputType.text,
                        obscureText: _obscurePassword.value,
                        hint: 'Password',
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () {
                            Get.to(ForgotPasswordScreen());
                          },
                          child: Text('Forgot Password?',
                              style: Theme.of(context)
                                  .textTheme
                                  .displayMedium!
                                  .copyWith(
                                      color: AppColors.textFieldBorderColor,
                                      fontSize: 15,
                                      decoration: TextDecoration.underline)),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      SizedBox(
                        width: 260,
                        child: RoundButton(
                            title: 'Login',
                            loading: value.loading,
                            onPress: () {
                              // isLoginButtonEnabled
                              //     ? () {
                              if (_formKey.currentState!.validate()) {
                                value
                                    .login(
                                      context,
                                      emailController.text.trim(),
                                      passwordController.text.trim(),
                                    )
                                    .then((value) {});
                              }
                              //   }
                              // : null;
                            }),
                      ),
                      SizedBox(height: 20.h),
                      // SizedBox(
                      //   width: 260,
                      //   child: RoundButton(
                      //       title: 'Signin with Google',
                      //       loading: value.loading,
                      //       onPress: () {
                      //         // if (_formKey.currentState!.validate()) {
                      //         value.loginWithGoogle(context);
                      //         // }
                      //       }),
                      // ),
                      // SizedBox(height: 20.h),
                      RichTextWidgets(
                        title: 'Not have an Account? ',
                        text: 'Sign Up',
                        onPressed: () {
                          Get.to(SignUpScreen());
                        },
                      ),
                    ],
                  ),
                ),
              )),
        ),
      ),
    );
  }
}
