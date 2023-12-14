import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:rpm/Views/ShopPart/AddToCartScreen/add_to_cart_screen.dart';
import 'package:rpm/Views/ShopPart/Auth/Components/big_text.dart';
import 'package:rpm/Views/ShopPart/ShopHomeScreen/ProductDescriptionScreen/add_to_cart_provider.dart';
import 'package:rpm/controllers/services/session_manager.dart';
import 'package:rpm/utils/utils.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../Utils/app_colors.dart';

class ProductDescriptionScreen extends StatefulWidget {
  final dynamic snap;
  const ProductDescriptionScreen({super.key, required this.snap});

  @override
  State<ProductDescriptionScreen> createState() =>
      _ProductDescriptionScreenState();
}

class _ProductDescriptionScreenState extends State<ProductDescriptionScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  double rating = 0.0;
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  // final List<String> imageList = [
  //   'assets/images/car_rim_img.png',
  //   'assets/images/car_rim_img.png',
  //   'assets/images/car_rim_img.png',
  // ];

  @override
  Widget build(BuildContext context) {
    final countProvider = Provider.of<CountProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: CustomText(
          title: "Product Description",
          fontWeight: FontWeight.w400,
          fontSize: 18.sp,
          color: AppColors.blackColor,
        ),
        actions: [
          StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(SessionController().userId)
                .snapshots(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text("Loading");
              }

              return GestureDetector(
                onTap: () async {
                  try {
                    if (snapshot.data
                        .get("cart")
                        .contains(widget.snap['docId'])) {
                      await FirebaseFirestore.instance
                          .collection('users')
                          .doc(SessionController().userId)
                          .update({
                        'cart': FieldValue.arrayRemove([widget.snap['docId']])
                      }).then((value) {
                        Utils.flushBarDoneMessage(
                            'Item removed from cart', context);
                      });
                    } else {
                      await FirebaseFirestore.instance
                          .collection('users')
                          .doc(SessionController().userId)
                          .update({
                        'cart': FieldValue.arrayUnion([widget.snap['docId']])
                      }).then((value) {
                        Utils.flushBarDoneMessage(
                            'Item added to cart', context);
                      });
                    }
                  } catch (e) {}
                },
                child: Center(
                    child: Icon(
                  snapshot.data.get("cart").contains(widget.snap['docId'])
                      ? Icons.shopping_cart
                      : Icons.shopping_cart_checkout_outlined,
                  size: 14.sp,
                  color: AppColors.grayText,
                )),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 5.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                SizedBox(
                  height: 180.h,
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    itemCount: widget.snap['productImage'].length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        margin: EdgeInsets.all(10),
                        child: Image.network(
                          widget.snap['productImage'][index],
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  ),
                ),
                AnimatedSmoothIndicator(
                  activeIndex: _currentPage,
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
            SizedBox(
              height: 25.h,
            ),
            CustomText(
              title: "Honda Civic Rebirth Genuine Alloy Wheels",
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.blackColor,
            ),
            SizedBox(
              height: 4.h,
            ),
            Row(
              children: [
                RatingBar.builder(
                  itemSize: 15.42.sp,
                  initialRating: rating,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  // itemPadding: EdgeInsets.symmetric(horizontal: 2.w),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Color(0xffF3CD03),
                  ),
                  onRatingUpdate: (newRating) {
                    rating = newRating; // Update the rating value
                  },
                ),
                SizedBox(
                  width: 10.h,
                ),
                CustomText(
                  title: "10 review",
                  fontWeight: FontWeight.w700,
                  fontSize: 9.50.sp,
                  color: AppColors.secondGTextColor,
                ),
                Spacer(),
                Container(
                  height: 28.h,
                  width: 28.w,
                  decoration: BoxDecoration(
                      // borderRadius: BorderRadius.circular(4),
                      shape: BoxShape.circle,
                      border: Border.all(color: Color(0xffEDEDED))
                      // color: AppColors.blackColor,
                      ),
                  child: StreamBuilder<DocumentSnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('products')
                        .doc(widget.snap['docId'])
                        .snapshots(),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.hasError) {
                        return Text('Something went wrong');
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Text("Loading");
                      }

                      return GestureDetector(
                        onTap: () async {
                          try {
                            if (snapshot.data
                                .get("favorite")
                                .contains(SessionController().userId)) {
                              await FirebaseFirestore.instance
                                  .collection('products')
                                  .doc(widget.snap['docId'])
                                  .update({
                                'favorite': FieldValue.arrayRemove(
                                    [SessionController().userId])
                              }).then((value) {
                                Utils.flushBarDoneMessage(
                                    'Item removed from cart', context);
                              });
                            } else {
                              await FirebaseFirestore.instance
                                  .collection('products')
                                  .doc(widget.snap['docId'])
                                  .update({
                                'favorite': FieldValue.arrayUnion(
                                    [SessionController().userId])
                              }).then((value) {
                                Utils.flushBarDoneMessage(
                                    'Item added to cart', context);
                              });
                            }
                          } catch (e) {}
                        },
                        child: Center(
                            child: Icon(
                          snapshot.data
                                  .get("favorite")
                                  .contains(SessionController().userId)
                              ? Icons.favorite
                              : Icons.favorite_border,
                          size: 14.sp,
                          color: AppColors.grayText,
                        )),
                      );
                    },
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            CustomText(
              title: "\$${1000}",
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.textColorB,
            ),
            SizedBox(
              height: 10.h,
            ),
            Row(
              children: [
                CustomText(
                  title: "Availability :",
                  fontWeight: FontWeight.w700,
                  fontSize: 9.50.sp,
                  color: AppColors.secondGTextColor,
                ),
                SizedBox(
                  width: 6.h,
                ),
                CustomText(
                  title: "In Stock ",
                  fontWeight: FontWeight.w700,
                  fontSize: 9.81.sp,
                  color: AppColors.greenTextColor,
                ),
              ],
            ),
            SizedBox(
              height: 8.h,
            ),
            CustomText(
              title:
                  "Honda Civic Rebirth Genuine Alloy Wheels are made from an\naluminum or magnesium. Combinations are blends of a\nmetaland other components.",
              fontWeight: FontWeight.w400,
              fontSize: 10.sp,
              color: AppColors.blackColor.withOpacity(.70),
            ),
            SizedBox(
              height: 25.h,
            ),
            // Row(
            //   children: [
            //     CustomText(
            //       title: "Color :",
            //       fontWeight: FontWeight.w700,
            //       fontSize: 10.sp,
            //       color: AppColors.secondGTextColor,
            //     ),
            //     SizedBox(
            //       width: 8.w,
            //     ),
            //     Container(
            //       height: 21.h,
            //       width: 21.w,
            //       decoration: BoxDecoration(
            //         shape: BoxShape.circle,
            //         color: AppColors.blackColor,
            //       ),
            //     ),
            //     SizedBox(
            //       width: 8.w,
            //     ),
            //     Container(
            //       height: 21.h,
            //       width: 21.w,
            //       decoration: BoxDecoration(
            //         shape: BoxShape.circle,
            //         color: AppColors.redTextColor,
            //       ),
            //     ),
            //     SizedBox(
            //       width: 8.w,
            //     ),
            //     Container(
            //       height: 21.h,
            //       width: 21.w,
            //       decoration: BoxDecoration(
            //         shape: BoxShape.circle,
            //         gradient: LinearGradient(
            //           begin: Alignment.centerLeft,
            //           end: Alignment.centerRight,
            //           colors: [
            //             Color(0xff37DBFF),
            //             Color(0xffC2FF42)
            //           ], // Set your desired colors here
            //           stops: [
            //             0.5,
            //             0.6
            //           ], // Adjust the stops to control the space between colors
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
            // SizedBox(
            //   height: 35.h,
            // ),
            Row(
              children: [
                CustomText(
                  title: "Weight :",
                  fontWeight: FontWeight.w600,
                  fontSize: 10.sp,
                  color: AppColors.secondGTextColor,
                ),
                SizedBox(
                  width: 8.w,
                ),
                Container(
                  height: 21.h,
                  width: 21.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: AppColors.greySeTextColor)
                      // color: AppColors.blackColor,
                      ),
                  child: Center(
                    child: CustomText(
                      title: "KG",
                      fontWeight: FontWeight.w600,
                      fontSize: 10.sp,
                      color: AppColors.secondGTextColor,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            Row(
              children: [
                Container(
                  height: 42.h,
                  width: 108.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: AppColors.greySeTextColor),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          icon: Icon(Icons.remove,
                              size: 12.sp, color: AppColors.secondGTextColor),
                          onPressed: () {
                            countProvider.decrement();
                          },
                        ),
                        CustomText(
                          title: countProvider.count.toString(),
                          fontWeight: FontWeight.w600,
                          fontSize: 12.sp,
                          color: AppColors.secondGTextColor,
                        ),
                        IconButton(
                          icon: Icon(Icons.add,
                              size: 12.sp, color: AppColors.secondGTextColor),
                          onPressed: () {
                            countProvider.increment();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                GestureDetector(
                  onTap: () {
                    // Get.to(AddToCartScreen());
                  },
                  child: Container(
                    height: 42.h,
                    width: 108.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.textFieldBorderColor,
                    ),
                    child: Center(
                      child: CustomText(
                        title: "Add To Cart",
                        fontWeight: FontWeight.w400,
                        fontSize: 10.sp,
                        color: AppColors.whiteColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
