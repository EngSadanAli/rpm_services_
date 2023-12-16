// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../Utils/app_colors.dart';

class AddressTextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode? focusNode;
  final FormFieldSetter onFieldSubmittedValue;
  String? Function(String?)? validator;
  final VoidCallback? onTap;
  final TextStyle? fontStyle;
  final TextInputType keyBoardType;
  final String? hint;
  final String? errorText;
  final bool obscureText;
  final bool? enable;
  int? maxLines = 1;
  final bool autoFocus;
  bool readOnly = false;
  final Function(String)? onChange;
  AddressTextFieldWidget({
    super.key,
    required this.controller,
    this.focusNode,
    required this.onFieldSubmittedValue,
    this.onTap,
    this.errorText,
    required this.keyBoardType,
    required this.obscureText,
    this.onChange,
    this.hint,
    this.fontStyle,
    this.enable,
    this.validator,
    this.maxLines,
    required this.readOnly,
    this.autoFocus = false,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextFormField(
          readOnly: readOnly,
          maxLines: maxLines,
          controller: controller,
          focusNode: focusNode,
          obscureText: obscureText,
          onChanged: onChange,
          enabled: enable,
          onTap: onTap,
          validator: validator,
          keyboardType: keyBoardType,
          cursorColor: AppColors.blackText,
          style: TextStyle(color: AppColors.blackColor),
          decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              hintText: hint,
              focusColor: Colors.grey,
              border: InputBorder.none,
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(2.r),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(2.r),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(2.r),
              ))),
    );
  }
}
