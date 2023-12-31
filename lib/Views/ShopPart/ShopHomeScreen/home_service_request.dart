import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rpm/Views/SettingScreen/NotificationScreen/notification_screen.dart';
import 'package:rpm/Views/ShopPart/ShopHomeScreen/ProductDescriptionScreen/product_description_screen.dart';
import 'package:rpm/Views/Utils/app_images.dart';
import '../../../widgets/custom_drawer.dart';
import '../../Utils/app_colors.dart';
import '../Auth/Components/big_text.dart';

class HomeServicesRequest extends StatefulWidget {
   HomeServicesRequest({super.key});

  @override
  State<HomeServicesRequest> createState() => _HomeServicesRequestState();
}

class _HomeServicesRequestState extends State<HomeServicesRequest> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        backgroundColor: AppColors.textFieldBorderColor,
          child: ListView(
      children: [
      DrawerHeader(
        padding: EdgeInsets.only(top: 20.h),
      decoration: BoxDecoration(
        color: AppColors.textFieldBorderColor,
      ),
        child: Column(
        children: [
          CircleAvatar(
            radius: 40.sp,
            backgroundImage: AssetImage(AppImages.profileImg),
          ),
          SizedBox(height: 15.h,),
          CustomText(
            title: "Mr.John",
            fontWeight:FontWeight.w700,
            fontSize: 15.sp,
            color: AppColors.whiteColor,
          ),
        ],
      ),
    ),
   Padding(
     padding:  EdgeInsets.only(right: 100.w),
     child: Column(
       children: [
         ListTile(
           leading: Icon(Icons.perm_identity,color: AppColors.whiteColor,),
           title: CustomText(
             title: "Profile",
             fontWeight:FontWeight.w700,
             fontSize: 15.sp,
             color: AppColors.whiteColor,
           ),

           onTap: () {
             // Add your onTap logic for item 1
           },
         ),
         Divider(thickness: 1,color: Colors.black,),
         ListTile(
           leading: Icon(Icons.signal_cellular_alt,color: AppColors.whiteColor,),
           title: CustomText(
             title: "Stats",
             fontWeight:FontWeight.w700,
             fontSize: 15.sp,
             color: AppColors.whiteColor,
           ),

           onTap: () {
             // Add your onTap logic for item 1
           },
         ),
         Divider(thickness: 1,color: Colors.black,),
         ListTile(
           leading: Icon(Icons.menu_book,color: AppColors.whiteColor,),
           title: CustomText(
             title: "Previous work",
             fontWeight:FontWeight.w700,
             fontSize: 15.sp,
             color: AppColors.whiteColor,
           ),

           onTap: () {
             // Add your onTap logic for item 1
           },
         ),
         Divider(thickness: 1,color: Colors.black,),
         ListTile(
           leading: Icon(Icons.favorite_border,color: AppColors.whiteColor,),
           title: CustomText(
             title: "Favorites",
             fontWeight:FontWeight.w700,
             fontSize: 15.sp,
             color: AppColors.whiteColor,
           ),

           onTap: () {
             // Add your onTap logic for item 1
           },
         ),
         Divider(thickness: 1,color: Colors.black,),
         ListTile(
           leading: Icon(Icons.help_outline,color: AppColors.whiteColor,),
           title: CustomText(
             title: "Help",
             fontWeight:FontWeight.w700,
             fontSize: 15.sp,
             color: AppColors.whiteColor,
           ),

           onTap: () {
             // Add your onTap logic for item 1
           },
         ),
         Divider(thickness: 1,color: Colors.black,),
         SizedBox(height: 70.h,),
         Divider(thickness: 1,color: Colors.black,),
         ListTile(
           leading: Icon(Icons.logout,color: AppColors.whiteColor,),
           title: CustomText(
             title: "LogOut",
             fontWeight:FontWeight.w700,
             fontSize: 15.sp,
             color: AppColors.whiteColor,
           ),

           onTap: () {
             // Add your onTap logic for item 1
           },
         ),
         Divider(thickness: 1,color: Colors.black,),

       ],
     ),
   )

    ],
    ),
      ),
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(
          color: AppColors.textFieldBorderColor
        ),
        backgroundColor: AppColors.whiteColor,
        title: SizedBox(
          height: 35.h,
           child: Row(
            children: [
          Expanded(
             child: Container(
            height: 35.h,
            child: TextField(
            textAlign: TextAlign.start,  // Center the input text
            style: TextStyle(
              color: AppColors.blackColor,
            ),
            decoration: InputDecoration(
              suffixIcon: Icon(Icons.search, color: AppColors.textFieldTextColor),
              hintText: 'Search',
              hintStyle: TextStyle(
                color: AppColors.textFieldTextColor,
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(15.r),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.textFieldTextColor),
                borderRadius: BorderRadius.circular(15.r),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.r),
                borderSide: BorderSide(color: AppColors.textFieldTextColor),
              ),
              disabledBorder: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(vertical: 15.0.h, horizontal: 10.w),
            ),
          ),
        ),
      ),
            SizedBox(width: 8.w,),
            InkWell(
          onTap: (){
           Get.to(NotificationScreen());
          },
          child: Icon(Icons.notifications_outlined,color: AppColors.blackColor,)),
      SizedBox(width: 12.w,),
    ],
  ),
),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding:  EdgeInsets.only(left: 16.w,top: 20.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            CustomText(title: "Shop Parts",
              color: AppColors.blackColor,
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(height: 30.h,),
            SizedBox(
              height: 140.h,
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children: [
                  Container(
                    margin: EdgeInsets.all(8),
                    padding: EdgeInsets.only(left: 15.w,right: 10.w,top: 12.h),
                    height: 131.h,
                    width: 234.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: AppColors.textFieldBorderColor,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          title: "Repair Service",
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),

                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Image.asset(AppImages.servicesImg,width: 141.w,height: 100.h,),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(8),
                    padding: EdgeInsets.only(left: 15.w,right: 10.w,top: 12.h),
                    height: 131.h,
                    width: 234.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: AppColors.textFieldBorderColor,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          title: "Book Service",
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),

                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Image.asset(AppImages.servicesImg,width: 141.w,height: 100.h,),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 22.h,),
            CustomText(title: "Popular Items",
              color: AppColors.blackColor,
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(height: 10.h,),
            GridView.builder(
              shrinkWrap: true,
              itemCount: 4,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 1.5 / 2,
                crossAxisSpacing: 12,
                mainAxisExtent: 140,
                mainAxisSpacing: 20,
              ),
              itemBuilder: (context, index) {
                return  Padding(
                  padding:  EdgeInsets.only(right: 16.w,left: 5),
                  child: GestureDetector(
                    onTap: (){
                      Get.to(ProductDescriptionScreen());
                    },
                    child: Container(
                      padding: EdgeInsets.only(top: 10.h,left: 8.w,right: 8.w),
                      height:146.h ,
                      width: 165.w,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppColors.grayText),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.25), // Shadow color
                            spreadRadius: 0,
                            blurRadius: 4,
                            offset: Offset(0, 4), // Offset in x and y direction
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Image.asset(AppImages.pngWingImg),
                          SizedBox(height: 4.h,),
                          CustomText(title: "Car Rim",
                            color: AppColors.blackColor,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                          ),
                          SizedBox(height: 6.h,),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomText(title: "1200",
                                color: AppColors.blackColor.withOpacity(.50),
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w400,
                              ),
                              SizedBox(width: 10.w,),
                              CustomText(title: "1000",
                                color: AppColors.blackColor.withOpacity(.50),
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w400,
                              ),
                              SizedBox(width: 10.w,),
                              CustomText(title: "10% off",
                                color: AppColors.redTextColor,
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },),
            SizedBox(height: 30.h,),
            CustomText(title: "Recently Viewed",
              color: AppColors.blackColor,
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
              SizedBox(height: 15.h,),
            GridView.builder(
              shrinkWrap: true,
              itemCount: 2,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 1.5 / 2,
                crossAxisSpacing: 12,
                mainAxisExtent: 140,
                mainAxisSpacing: 20,
              ),
              itemBuilder: (context, index) {
                return  Padding(
                  padding:  EdgeInsets.only(right: 16.w,left: 5),
                  child: Container(
                    padding: EdgeInsets.only(top: 10.h,left: 8.w,right: 8.w),
                    height:146.h ,
                    width: 165.w,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColors.grayText),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black54.withOpacity(0.35), // Shadow color
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3), // Offset in x and y direction
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Image.asset(AppImages.carSteering),
                        SizedBox(height: 4.h,),
                        CustomText(title: "Car Steering",
                          color: AppColors.blackColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                        ),
                        SizedBox(height: 6.h,),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomText(title: "1200",
                              color: AppColors.blackColor.withOpacity(.50),
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w400,
                            ),
                            SizedBox(width: 10.w,),
                            CustomText(title: "1000",
                              color: AppColors.blackColor.withOpacity(.50),
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w400,
                            ),
                            SizedBox(width: 10.w,),
                            CustomText(title: "10% off",
                              color: AppColors.redTextColor,
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },),
            SizedBox(height: 15.h,)
            ],
          ),
        ),
      ),
    );
  }
}