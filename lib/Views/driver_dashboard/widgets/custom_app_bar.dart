import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../ShopPart/Auth/Components/big_text.dart';
import '../../../utils/app_colors.dart';
class CustomAppBar extends StatelessWidget {
  final String title;
  const CustomAppBar({super.key,required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(onPressed: (){
        Get.back();
      },
        icon: Icon(Icons.arrow_back,color: Colors.black,),
      ),
      title: CustomText(title: title,
        fontWeight: FontWeight.w400,
        fontSize: 18.sp,
        color: AppColors.blackColor,
      ),
      actions: [
        IconButton(onPressed: (){}, icon: Icon(Icons.shopping_cart_outlined,color: AppColors.blackColor,))
      ],
    );
  }
}
