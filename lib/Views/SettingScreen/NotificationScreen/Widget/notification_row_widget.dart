import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../ShopPart/Auth/Components/big_text.dart';
import '../../../Utils/app_colors.dart';
class NotificationRowWidget extends StatefulWidget {
  const NotificationRowWidget({super.key});

  @override
  State<NotificationRowWidget> createState() => _NotificationRowWidgetState();
}

class _NotificationRowWidgetState extends State<NotificationRowWidget> {
  bool switchValue = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(title: "Show Notifications",
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
          color: AppColors.blackColor.withOpacity(.87),
        ),
        Switch(
          value: switchValue,
          onChanged: (newValue) {

            setState(() {
              switchValue = newValue;
            });
          },
        ),
      ],
    );
  }
}
