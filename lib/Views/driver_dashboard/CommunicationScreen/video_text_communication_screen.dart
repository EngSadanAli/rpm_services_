
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rpm/Views/driver_dashboard/ShopPart/Auth/Components/big_text.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_images.dart';


class VideoTextCommunication extends StatelessWidget {
  // DoctorPatientCommunication({super.key});
  bool tabButtons = false;

  int dietPosition = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColors.textFieldBorderColor,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: AppColors.textFieldBorderColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      )),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 90.w,
                                  height: 90.w,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                      child: Image.asset(AppImages.manOneImg),
                                  ),
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                CustomText(
                                    title: "John",
                                    color: Colors.white,
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w500),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Container(
                                  // /   color: Colors.red,
                                  // width: MySize.scaleFactorWidth * 148,
                                  child: Text(
                                    'is simply dummy text of the\nprinting and typesetting\nindustry. Lorem Ipsu\nhas been.',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 10.sp),
                                    textAlign: TextAlign.justify,
                                  ),
                                )
                              ],
                            ),
                            // Icon(Icons.sync_alt,color: AppColors.whiteColor,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 90.h,
                                  width: 90.w,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child:Image.asset(AppImages.manTwoImg),
                                  ),
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomText(
                                        title: "Mr.jhon Albert",
                                        color: Colors.white,
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w500),
                                  ],
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Container(
                                  // width: MySize.scaleFactorWidth * 148,
                                  child: Text(
                                    'Is simply dummy text of the\nprinting and typesetting\nindustry.Lorem Ipsu\nhas been.',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 10.sp),
                                    textAlign: TextAlign.justify,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height:40.h,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height:15.sp,
                ),
                Container(
                  height: 50.sp,
                  width:  360,
                  margin: EdgeInsets.only(left: 15.w,right: 15.w),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 10,
                          spreadRadius: 0,
                          offset: Offset(0, 2))
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: TabBar(
                      unselectedLabelColor: Color(0xffBEBEBE),
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.textFieldBorderColor,
                      ),
                      tabs: [
                        Tab(
                          text: 'Text',
                        ),
                        Tab(
                          text: 'Call',
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height:  370.h,
                  width: double.infinity,
                  child: TabBarView(
                    //  physics: AlwaysScrollableScrollPhysics(),
                      children: [
                    Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                       SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 230.h,
                            ),
                            Padding(
                              padding:  EdgeInsets.only(left: 15.w,right: 15.w),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10),

                                      height:
                                      50.h,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(9),
                                        color: AppColors.whiteColor,
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.black.withOpacity(0.15),
                                              blurRadius: 10,
                                              spreadRadius: 0,
                                              offset: Offset(0, 1.7))
                                        ],
                                      ),
                                      child: SizedBox(
                                        //  height: MySize.size200,
                                        child: TextField(
                                          //minLines: 1,
                                          maxLines: 14,
                                          decoration: InputDecoration(
                                              focusedBorder:
                                              OutlineInputBorder(
                                                borderRadius:
                                                BorderRadius.circular(
                                                    10),
                                                borderSide: BorderSide.none
                                              ),
                                              enabledBorder:
                                              OutlineInputBorder(borderSide: BorderSide.none),
                                              hintText: 'Type a massage',
                                              hintStyle: TextStyle(
                                                  color:
                                                  Color(0xffBEBEBE),
                                                  fontSize: 14.sp,
                                                  fontWeight:
                                                  FontWeight.w400)),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10.w,),
                                  Container(
                                    height: 45.93.h,
                                    width: 45.93.w,
                                    decoration: BoxDecoration(
                                      color: AppColors.whiteColor,
                                      borderRadius: BorderRadius.circular(8),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.black.withOpacity(0.15),
                                            blurRadius: 10,
                                            spreadRadius: 0,
                                            offset: Offset(0, 1.7))
                                      ],
                                    ),
                                    child: Icon(Icons.send,color: AppColors.textFieldBorderColor,),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 100.h,
                              width: 100.w,
                              decoration: BoxDecoration(boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.15),
                                    spreadRadius: 0,
                                    offset: Offset(0, 2),
                                    blurRadius: 10.0)
                              ], color: Colors.white, shape: BoxShape.circle),
                              child: Icon(
                                Icons.add_call,
                                color: Colors.black,
                                size: 50.sp,
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            CustomText(
                                title: "Start Audio Call",
                                color: Color(0xff2C2C2C),
                                fontWeight: FontWeight.w500,
                                fontSize: 18)
                          ],
                        )
                      ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}