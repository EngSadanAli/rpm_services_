import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rpm/Views/driver_dashboard/LocationScreen/my_location_screen.dart';
import 'package:rpm/Views/driver_dashboard/PreviousWorkScreen/PreviousWorkScreen.dart';
import 'package:rpm/Views/driver_dashboard/SettingScreen/NotificationScreen/notification_screen.dart';
import 'package:rpm/Views/driver_dashboard/ShopPart/Auth/LogInScreen/login_screen.dart';
import 'package:rpm/Views/driver_dashboard/ShopPart/ShopHomeScreen/HelpScreen.dart';
import 'package:rpm/Views/driver_dashboard/ShopPart/ShopHomeScreen/ProductDescriptionScreen/product_description_screen.dart';
import 'package:rpm/Views/profile/profile_detail_screen.dart';
import 'package:rpm/utils/app_images.dart';
import 'package:rpm/Views/profile/profile_screen.dart';
import 'package:rpm/controllers/services/session_manager.dart';
import 'package:rpm/utils/utils.dart';
import 'package:rpm/Views/driver_dashboard/widgets/network_image_widget.dart';
import '../../widgets/custom_drawer.dart';
import '../../../../utils/app_colors.dart';
import '../Auth/Components/big_text.dart';

class HomeServicesRequest extends StatefulWidget {
  HomeServicesRequest({super.key});

  @override
  State<HomeServicesRequest> createState() => _HomeServicesRequestState();
}

class _HomeServicesRequestState extends State<HomeServicesRequest> {
  final TextEditingController searchController = TextEditingController();
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
                  StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .doc(SessionController().userId)
                        .snapshots(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasError) {
                        return Text('Something went wrong');
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return NetworkImageWidget(
                          height: 80,
                          width: 80,
                          borderRadius: 100,
                          imageUrl: SessionController().profilePic.toString(),
                        );
                      }
                      return NetworkImageWidget(
                        height: 80,
                        width: 80,
                        borderRadius: 100,
                        imageUrl: snapshot.data.get('profileImage').toString(),
                      );
                    },
                  ),
                  SizedBox(height: 15.h),
                  CustomText(
                    title: SessionController().name.toString(),
                    fontWeight: FontWeight.w700,
                    fontSize: 15.sp,
                    color: AppColors.whiteColor,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 100.w),
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(
                      Icons.perm_identity,
                      color: AppColors.whiteColor,
                    ),
                    title: CustomText(
                      title: "Profile",
                      fontWeight: FontWeight.w700,
                      fontSize: 15.sp,
                      color: AppColors.whiteColor,
                    ),
                    onTap: () {
                      // Add your onTap logic for item 1
                      Get.to(ProfileDetails(showBackButton: true));
                    },
                  ),
                  Divider(
                    thickness: 1,
                    color: Colors.black,
                  ),
                  // ListTile(
                  //   leading: Icon(
                  //     Icons.signal_cellular_alt,
                  //     color: AppColors.whiteColor,
                  //   ),
                  //   title: CustomText(
                  //     title: "Stats",
                  //     fontWeight: FontWeight.w700,
                  //     fontSize: 15.sp,
                  //     color: AppColors.whiteColor,
                  //   ),
                  //   onTap: () {
                  //     // Add your onTap logic for item 1
                  //   },
                  // ),
                  // Divider(
                  //   thickness: 1,
                  //   color: Colors.black,
                  // ),
                  ListTile(
                    leading: Icon(
                      Icons.menu_book,
                      color: AppColors.whiteColor,
                    ),
                    title: CustomText(
                      title: "Previous work",
                      fontWeight: FontWeight.w700,
                      fontSize: 15.sp,
                      color: AppColors.whiteColor,
                    ),
                    onTap: () {
                      // Add your onTap logic for item 1
                      Get.to(PreviousWorkScreen());
                    },
                  ),
                  Divider(
                    thickness: 1,
                    color: Colors.black,
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.favorite_border,
                      color: AppColors.whiteColor,
                    ),
                    title: CustomText(
                      title: "Favorites",
                      fontWeight: FontWeight.w700,
                      fontSize: 15.sp,
                      color: AppColors.whiteColor,
                    ),
                    onTap: () {
                      // Add your onTap logic for item 1
                      Get.to(MyWishlistScreen(
                        showBackButton: true,
                      ));
                    },
                  ),
                  Divider(
                    thickness: 1,
                    color: Colors.black,
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.help_outline,
                      color: AppColors.whiteColor,
                    ),
                    title: CustomText(
                      title: "Help",
                      fontWeight: FontWeight.w700,
                      fontSize: 15.sp,
                      color: AppColors.whiteColor,
                    ),
                    onTap: () {
                      // Add your onTap logic for item 1
                      Get.to(HelpScreen());
                    },
                  ),
                  Divider(
                    thickness: 1,
                    color: Colors.black,
                  ),
                  SizedBox(
                    height: 70.h,
                  ),
                  Divider(
                    thickness: 1,
                    color: Colors.black,
                  ),
                  ListTile(
                      leading: Icon(
                        Icons.logout,
                        color: AppColors.whiteColor,
                      ),
                      title: CustomText(
                        title: "LogOut",
                        fontWeight: FontWeight.w700,
                        fontSize: 15.sp,
                        color: AppColors.whiteColor,
                      ),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog.adaptive(
                              backgroundColor: AppColors.textFieldBorderColor,
                              title: Text('Logout'),
                              content: Text('Are you sure you want to logout?'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    // // Perform logout action here
                                    // Navigator.of(context).pop(); // Close the dialog
                                    FirebaseAuth.instance
                                        .signOut()
                                        .then((value) {
                                      SessionController().userId = '';
                                      SessionController().profilePic = '';
                                      SessionController().name = '';
                                      SessionController().email = '';
                                      SessionController().phone = '';
                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => LoginScreen(),
                                          ),
                                          (route) => false);
                                    });
                                  },
                                  child: Text('OK',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall!),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pop(); // Close the dialog
                                  },
                                  child: Text('Cancel',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall!),
                                ),
                              ],
                            );
                          },
                        );
                      }),
                  Divider(
                    thickness: 1,
                    color: Colors.black,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: AppColors.textFieldBorderColor),
        backgroundColor: AppColors.whiteColor,
        title: SizedBox(
          height: 35.h,
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: 35.h,
                  child: TextField(
                    controller: searchController,
                    onChanged: (value) => setState(() {}),
                    textAlign: TextAlign.start, // Center the input text
                    style: TextStyle(
                      color: AppColors.blackColor,
                    ),
                    decoration: InputDecoration(
                      // suffixIcon: Icon(Icons.search,
                      //     color: AppColors.textFieldTextColor),
                      hintText: 'Search',
                      hintStyle: TextStyle(
                        color: AppColors.textFieldTextColor,
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(15.r),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: AppColors.textFieldTextColor),
                        borderRadius: BorderRadius.circular(15.r),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.r),
                        borderSide:
                            BorderSide(color: AppColors.textFieldTextColor),
                      ),
                      disabledBorder: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        vertical:
                            8.0.h, // Adjust this value for vertical centering
                        horizontal: 10.w,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 8.w,
              ),
              InkWell(
                  onTap: () {
                    Get.to(NotificationScreen());
                  },
                  child: Icon(
                    Icons.notifications_outlined,
                    color: AppColors.blackColor,
                  )),
              SizedBox(
                width: 12.w,
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(left: 16.w, top: 20.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // CustomText(
              //   title: "Shop Parts",
              //   color: AppColors.blackColor,
              //   fontSize: 20.sp,
              //   fontWeight: FontWeight.bold,
              // ),
              // SizedBox(
              //   height: 30.h,
              // ),
              // SizedBox(
              //   height: 140.h,
              //   child: ListView(
              //     shrinkWrap: true,
              //     scrollDirection: Axis.horizontal,
              //     children: [
              //       Container(
              //         margin: EdgeInsets.all(8),
              //         padding:
              //             EdgeInsets.only(left: 15.w, right: 10.w, top: 12.h),
              //         height: 131.h,
              //         width: 234.h,
              //         decoration: BoxDecoration(
              //           borderRadius: BorderRadius.circular(10.r),
              //           color: AppColors.textFieldBorderColor,
              //         ),
              //         child: Column(
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: [
              //             CustomText(
              //               title: "Repair Service",
              //               fontSize: 16.sp,
              //               fontWeight: FontWeight.w400,
              //               color: Colors.white,
              //             ),
              //             Row(
              //               crossAxisAlignment: CrossAxisAlignment.end,
              //               mainAxisAlignment: MainAxisAlignment.end,
              //               children: [
              //                 Image.asset(
              //                   AppImages.servicesImg,
              //                   width: 141.w,
              //                   height: 100.h,
              //                 ),
              //               ],
              //             ),
              //           ],
              //         ),
              // ),
              //       Container(
              //         margin: EdgeInsets.all(8),
              //         padding:
              //             EdgeInsets.only(left: 15.w, right: 10.w, top: 12.h),
              //         height: 131.h,
              //         width: 234.h,
              //         decoration: BoxDecoration(
              //           borderRadius: BorderRadius.circular(10.r),
              //           color: AppColors.textFieldBorderColor,
              //         ),
              //         child: Column(
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: [
              //             CustomText(
              //               title: "Book Service",
              //               fontSize: 16.sp,
              //               fontWeight: FontWeight.w400,
              //               color: Colors.white,
              //             ),
              //             Row(
              //               crossAxisAlignment: CrossAxisAlignment.end,
              //               mainAxisAlignment: MainAxisAlignment.end,
              //               children: [
              //                 Image.asset(
              //                   AppImages.servicesImg,
              //                   width: 141.w,
              //                   height: 100.h,
              //                 ),
              //               ],
              //             ),
              //           ],
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              SizedBox(
                height: 22.h,
              ),
              CustomText(
                title: "Products",
                color: AppColors.blackColor,
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
              SizedBox(
                height: 10.h,
              ),
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('products')
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text('Something went wrong');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text("Loading");
                  }

                  // Filter the products based on search text
                  final List<DocumentSnapshot> filteredProducts =
                      snapshot.data!.docs.where((product) {
                    final title = product['title'].toString().toLowerCase();
                    final searchText = searchController.text.toLowerCase();
                    return title.contains(searchText);
                  }).toList();

                  if (filteredProducts.isEmpty) {
                    return Text('No matching products found');
                  }

                  return GridView.builder(
                    shrinkWrap: true,
                    itemCount: filteredProducts.length,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      childAspectRatio: 1.5 / 2,
                      crossAxisSpacing: 12,
                      mainAxisExtent: 140,
                      mainAxisSpacing: 20,
                    ),
                    itemBuilder: (context, index) {
                      var snap = filteredProducts[index];
                      // rest of your item builder code...
                      return Padding(
                        padding: EdgeInsets.only(right: 16.w, left: 5),
                        child: GestureDetector(
                          onTap: () {
                            Get.to(ProductDescriptionScreen(snap: snap));
                          },
                          child: Container(
                            padding: EdgeInsets.only(
                                top: 10.h, left: 8.w, right: 8.w),
                            height: 146.h,
                            width: 165.w,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: AppColors.grayText),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black
                                      .withOpacity(0.25), // Shadow color
                                  spreadRadius: 0,
                                  blurRadius: 4,
                                  offset: Offset(
                                      0, 4), // Offset in x and y direction
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                NetworkImageWidget(
                                    height: 80,
                                    width: 90,
                                    imageUrl: snap['productImage'][0]),
                                // Image.network(snap['productImage'][0]),
                                CustomText(
                                  title: snap['title'],
                                  color: AppColors.blackColor,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CustomText(
                                      title: "\$",
                                      color:
                                          AppColors.blackColor.withOpacity(.50),
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    CustomText(
                                      title: snap['price'],
                                      color:
                                          AppColors.blackColor.withOpacity(.50),
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    // SizedBox(
                                    //   width: 10.w,
                                    // ),
                                    // CustomText(
                                    //   title: "10% off",
                                    //   color: AppColors.redTextColor,
                                    //   fontSize: 10.sp,
                                    //   fontWeight: FontWeight.w400,
                                    // ),
                                    Spacer(),
                                    StreamBuilder<DocumentSnapshot>(
                                      stream: FirebaseFirestore.instance
                                          .collection('products')
                                          .doc(snap['docId'])
                                          .snapshots(),
                                      builder:
                                          (context, AsyncSnapshot snapshot) {
                                        if (snapshot.hasError) {
                                          return Text('Something went wrong');
                                        }

                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return Text("Loading");
                                        }

                                        return GestureDetector(
                                          onTap: () async {
                                            try {
                                              if (snapshot.data
                                                  .get("favorite")
                                                  .contains(SessionController()
                                                      .userId)) {
                                                await FirebaseFirestore.instance
                                                    .collection('products')
                                                    .doc(snap['docId'])
                                                    .update({
                                                  'favorite':
                                                      FieldValue.arrayRemove([
                                                    SessionController().userId
                                                  ])
                                                }).then((value) {
                                                  Utils.flushBarDoneMessage(
                                                      'Item removed from favorite',
                                                      context);
                                                });
                                              } else {
                                                await FirebaseFirestore.instance
                                                    .collection('products')
                                                    .doc(snap['docId'])
                                                    .update({
                                                  'favorite':
                                                      FieldValue.arrayUnion([
                                                    SessionController().userId
                                                  ])
                                                }).then((value) {
                                                  Utils.flushBarDoneMessage(
                                                      'Item added to favorite',
                                                      context);
                                                });
                                              }
                                            } catch (e) {}
                                          },
                                          child: Center(
                                              child: Icon(
                                            snapshot.data
                                                    .get("favorite")
                                                    .contains(
                                                        SessionController()
                                                            .userId)
                                                ? Icons.favorite
                                                : Icons.favorite_border,
                                            size: 14.sp,
                                            color: AppColors.grayText,
                                          )),
                                        );
                                      },
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                  // StreamBuilder<QuerySnapshot>(
                  //   stream: FirebaseFirestore.instance
                  //       .collection('products')
                  //       .snapshots(),
                  //   builder: (BuildContext context,
                  //       AsyncSnapshot<QuerySnapshot> snapshot) {
                  //     if (snapshot.hasError) {
                  //       return Text('Something went wrong');
                  //     }

                  //     if (snapshot.connectionState == ConnectionState.waiting) {
                  //       return Text("Loading");
                  //     }
                  //     return GridView.builder(
                  //       shrinkWrap: true,
                  //       itemCount: snapshot.data!.docs.length,
                  //       physics: NeverScrollableScrollPhysics(),
                  //       gridDelegate:
                  //           const SliverGridDelegateWithMaxCrossAxisExtent(
                  //         maxCrossAxisExtent: 200,
                  //         childAspectRatio: 1.5 / 2,
                  //         crossAxisSpacing: 12,
                  //         mainAxisExtent: 140,
                  //         mainAxisSpacing: 20,
                  //       ),
                  //       itemBuilder: (context, index) {
                  //         var snap = snapshot.data!.docs[index];

                  //       },
                  //     );
                },
              ),

              SizedBox(
                height: 30.h,
              ),
              // CustomText(
              //   title: "Recently Viewed",
              //   color: AppColors.blackColor,
              //   fontSize: 20.sp,
              //   fontWeight: FontWeight.bold,
              // ),
              // SizedBox(
              //   height: 15.h,
              // ),
              // GridView.builder(
              //   shrinkWrap: true,
              //   itemCount: 2,
              //   physics: NeverScrollableScrollPhysics(),
              //   gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              //     maxCrossAxisExtent: 200,
              //     childAspectRatio: 1.5 / 2,
              //     crossAxisSpacing: 12,
              //     mainAxisExtent: 140,
              //     mainAxisSpacing: 20,
              //   ),
              //   itemBuilder: (context, index) {
              //     return Padding(
              //       padding: EdgeInsets.only(right: 16.w, left: 5),
              //       child: Container(
              //         padding:
              //             EdgeInsets.only(top: 10.h, left: 8.w, right: 8.w),
              //         height: 146.h,
              //         width: 165.w,
              //         decoration: BoxDecoration(
              //           color: Colors.white,
              //           borderRadius: BorderRadius.circular(10),
              //           border: Border.all(color: AppColors.grayText),
              //           boxShadow: [
              //             BoxShadow(
              //               color: Colors.black54
              //                   .withOpacity(0.35), // Shadow color
              //               spreadRadius: 2,
              //               blurRadius: 5,
              //               offset: Offset(0, 3), // Offset in x and y direction
              //             ),
              //           ],
              //         ),
              //         child: Column(
              //           children: [
              //             Image.asset(AppImages.carSteering),
              //             SizedBox(
              //               height: 4.h,
              //             ),
              //             CustomText(
              //               title: "Car Steering",
              //               color: AppColors.blackColor,
              //               fontSize: 16.sp,
              //               fontWeight: FontWeight.w400,
              //             ),
              //             SizedBox(
              //               height: 6.h,
              //             ),
              //             Row(
              //               crossAxisAlignment: CrossAxisAlignment.center,
              //               mainAxisAlignment: MainAxisAlignment.center,
              //               children: [
              //                 CustomText(
              //                   title: "1200",
              //                   color: AppColors.blackColor.withOpacity(.50),
              //                   fontSize: 10.sp,
              //                   fontWeight: FontWeight.w400,
              //                 ),
              //                 SizedBox(
              //                   width: 10.w,
              //                 ),
              //                 CustomText(
              //                   title: "1000",
              //                   color: AppColors.blackColor.withOpacity(.50),
              //                   fontSize: 10.sp,
              //                   fontWeight: FontWeight.w400,
              //                 ),
              //                 SizedBox(
              //                   width: 10.w,
              //                 ),
              //                 CustomText(
              //                   title: "10% off",
              //                   color: AppColors.redTextColor,
              //                   fontSize: 10.sp,
              //                   fontWeight: FontWeight.w400,
              //                 ),
              //               ],
              //             )
              //           ],
              //         ),
              //       ),
              //     );
              //   },
              // ),
              // SizedBox(
              //   height: 15.h,
              // )
            ],
          ),
        ),
      ),
    );
  }
}
