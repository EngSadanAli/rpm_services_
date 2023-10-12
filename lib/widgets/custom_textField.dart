import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rpm/Views/Utils/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final FormFieldSetter onFieldSubmittedValue;
  String? Function(String?)? validator;
  final VoidCallback? onTap;
  final TextStyle? fontStyle;
  final TextInputType keyBoardType;
  final String? hint;
  final String? errorText;
  final Icon? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final bool? enable;
  int? maxLines = 1;
  final bool autoFocus;
  bool readOnly = false;
  final Function(String)? onChange;

  CustomTextField(
      {Key? key,
      required this.controller,
      required this.focusNode,
      required this.onFieldSubmittedValue,
      this.onTap,
      this.errorText,
      required this.keyBoardType,
      required this.obscureText,
      this.onChange,
      this.hint,
      this.fontStyle,
      this.prefixIcon,
      this.suffixIcon,
      this.enable,
      this.validator,
      this.maxLines,
      required this.readOnly,
      this.autoFocus = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //height: 50.h,
      width: double.infinity,
      decoration: BoxDecoration(

          borderRadius: BorderRadius.circular(10)),
      child: Center(
        child: TextFormField(
          readOnly: readOnly,
          maxLines: maxLines,
          controller: controller,
          focusNode: focusNode,
          obscureText: obscureText,
          onFieldSubmitted: onFieldSubmittedValue,
          validator: validator,
          onChanged: onChange,
          enabled: enable,
          onTap: onTap,
          keyboardType: keyBoardType,
          cursorColor: AppColors.blackText,
          style: TextStyle(color: AppColors.blackColor),
          decoration: InputDecoration(
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            hintText: hint,
            errorText: errorText,
            hintStyle: TextStyle(
              color: AppColors.textFieldTextColor,
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
            ),
            contentPadding: const EdgeInsets.all(10),
            border: InputBorder.none,
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: AppColors.textFieldBorderColor, width: 1.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.textFieldBorderColor,width: 1.5),
              borderRadius: BorderRadius.circular(10.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.textFieldBorderColor,width: 1.5),
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
      ),
    );
  }
}
