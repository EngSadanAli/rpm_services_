import 'dart:async';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rpm/Views/Utils/app_colors.dart';
import 'package:rpm/Views/Utils/app_images.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../LogInScreen/login_screen.dart';
import 'Components/container_widgets.dart';

class OnboardScreen extends StatefulWidget {
  const OnboardScreen({super.key});

  @override
  _OnboardScreenState createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int yourActiveIndex = 0;

  @override
  void dispose() {

    _pageController.dispose();
    super.dispose();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 4), () async {
      Get.to( LoginScreen());
    });
  }
  @override
  Widget build(BuildContext context){
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding:  EdgeInsets.only(),
          child: Stack(
            children: [
              PageView(
                controller: _pageController,
                onPageChanged: (int page) {
                  setState(() {
                    yourActiveIndex = page.toInt();
                  });
                },
                children: [
                  OnboardContainer(
                    text: 'Emergency service',
                    title: "would need to share Your location with\na pin drop and input Your Unit number",
                    image: AppImages.onBoardingOne,
                  ),
                  OnboardContainer(
                    text: 'SHOP parts ',
                    title: "Supreme Facial Car Sun Visor / Sunshade\nTissue Holder Case Box - Black ... etc",
                    image: AppImages.onBoardingTwo,
                  ),
                  OnboardContainer(
                    text: 'services Request ',
                    title: "The general repair, engine rebuilding or\nreconditioning of motor vehicles collision\nservice such as body,",
                    image: AppImages.onBoardingThree,
                  ),
                ],
              ),
              Positioned(
                bottom: 80.h,
                left: 0,
                right: 0,
                child: Column(
                  children: [
                    AnimatedSmoothIndicator(
                      activeIndex: yourActiveIndex,
                      count: 3,
                      effect: ExpandingDotsEffect(
                        activeDotColor: AppColors.textFieldBorderColor,
                        dotColor: AppColors.bottomColor,
                        dotWidth: 10.w,
                        dotHeight: 10.h,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
