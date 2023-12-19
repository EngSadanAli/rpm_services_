import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rpm/utils/app_images.dart';
import '../OnboardScreen/onboard_screen.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);
  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 3), () async {
      Get.to( OnboardScreen());
      // Get.to( LoginScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.mainLogo, ),fit: BoxFit.cover,
          )
        )
        // child: Image.asset(AppImages.mainLogo,
        //   fit: BoxFit.cover,
        // ),
      ),
    );
  }
}
