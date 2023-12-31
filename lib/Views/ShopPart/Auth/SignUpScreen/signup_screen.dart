import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rpm/Views/Utils/app_colors.dart';
import 'package:rpm/widgets/custom_textField.dart';
import '../../../../widgets/login_button_widgets.dart';
import '../../../../widgets/select_screen_widget.dart';
import '../../../Utils/app_images.dart';
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
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final conPasswordController = TextEditingController();
  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  final nameFocusNode = FocusNode();
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
      isLoginButtonEnabled = nameController.text.isNotEmpty
          && emailController.text.isNotEmpty
          && passwordController.text.isNotEmpty
          && conPasswordController.text.isNotEmpty;
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
            isLoginButtonEnabled = nameController.text.isNotEmpty
                && emailController.text.isNotEmpty
                && passwordController.text.isNotEmpty
                && conPasswordController.text.isNotEmpty;
          });
        },
        child: Padding(
          padding:  EdgeInsets.only(left: 20.w,right: 20.w,top: 80.h),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomText(
                    title: "New Here?",
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.w400,
                    fontSize:22.sp
                ),
                SizedBox(height: 15.h,),
                CustomText(
                    title: "Create an account to Continue",
                    color: AppColors.grayText2,
                    fontWeight: FontWeight.w400,
                    fontSize:14.sp
                ),
                SizedBox(height: 44.h,),
                CustomTextField(
                  readOnly: false,
                  controller: nameController,
                  focusNode: nameFocusNode,
                  onFieldSubmittedValue: (newValue) {},
                  keyBoardType: TextInputType.emailAddress,
                  obscureText: false,
                  prefixIcon: Icon(Icons.person_outline,color: AppColors.textFieldBorderColor),
                  hint: 'Name',
                  onChange: (value) {},
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your Name";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.h,),
                CustomTextField(
                  readOnly: false,
                  controller: emailController,
                  focusNode: emailFocusNode,
                  onFieldSubmittedValue: (newValue) {},
                  keyBoardType: TextInputType.emailAddress,
                  obscureText: false,
                  prefixIcon: Icon(Icons.email_outlined,color: AppColors.textFieldBorderColor),
                  hint: 'Email',
                  onChange: (value) {},
                  validator: (value) {
                    if (value == null || value.isEmpty || !GetUtils.isEmail(value)) {
                      return "Please enter a valid email";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.h,),
                CustomTextField(
                  readOnly: false,
                  maxLines: 1,
                  controller: passwordController,
                  focusNode: passwordFocusNode,
                  onFieldSubmittedValue: (newValue) {},
                  onChange: (value) {},
                  prefixIcon: Icon(Icons.lock_open_outlined,
                    color: AppColors.textFieldBorderColor,),
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
                SizedBox(height: 20.h,),
                CustomTextField(
                  readOnly: false,
                  controller: conPasswordController,
                  focusNode: conPasswordFocusNode,
                  onFieldSubmittedValue: (newValue) {},
                  keyBoardType: TextInputType.visiblePassword,
                  obscureText: false,
                  prefixIcon: Icon(Icons.lock_open_rounded,color: AppColors.textFieldBorderColor),
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
                SizedBox(height: 20.h,),
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
                        MaterialPageRoute(builder: (context) => LoginScreen()), // Replace with the desired screen
                      );
                    }
                  },
                  child: Container(
                    height: 50.0,
                    width: 340.0,
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(
                        color: AppColors.textFieldBorderColor, // Customize the border color
                        width: 1.5,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        DropdownButtonHideUnderline(
                          child: DropdownButton2<String>(

                            isExpanded: true,
                            hint:  Row(
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
                                style:  TextStyle(
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
                            iconStyleData:  IconStyleData(
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
                                thumbVisibility: MaterialStateProperty.all<bool>(true),
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
                SizedBox(height: 29.h,),
                ElevatedButton(
                  onPressed: isLoginButtonEnabled
                      ? () {
                    if (_formKey.currentState!.validate()) {
                      // Navigate to the LoginScreen
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    }
                  }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.textFieldBorderColor,
                    fixedSize: Size(154.w, 50.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: CustomText(
                    title: "SignUp",
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.whiteColor,
                  ),
                ),
                SizedBox(height: 50.h,),
                CustomText(
                    title: "or continue with",
                    color: AppColors.blackColor.withOpacity(0.70),
                    fontWeight: FontWeight.w400,
                    fontSize:14.sp
                ),
                SizedBox(height: 25.h,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset(AppImages.fbImg,width: 30.w,height: 30.h,),
                    // SizedBox(width: 54.h,),
                    Image.asset(AppImages.instImg,width: 30.w,height: 30.h,),
                    // SizedBox(width: 54.h,),
                    Image.asset(AppImages.googleImg,width: 30.w,height: 30.h,),
                  ],
                ),
                SizedBox(height: 40.h,),
                RichTextWidgets(
                  title: 'Already have an Account? ',
                  text: 'Sign In',
                  onPressed: () {
                    Get.to( LoginScreen());
                  },
                ),
                SizedBox(height: 30.h,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
