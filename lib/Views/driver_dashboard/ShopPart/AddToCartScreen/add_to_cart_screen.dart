// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:provider/provider.dart';
// import 'package:rpm/Views/driver_dashboard/PaymentSection/AddressScreem/home_address_screem.dart';
// import 'package:rpm/Views/driver_dashboard/ShopPart/AddToCartScreen/add_cart_row_widget.dart';
// import 'package:rpm/Views/driver_dashboard/ShopPart/Auth/Components/big_text.dart';
// import 'package:rpm/Views/driver_dashboard/ShopPart/ShopHomeScreen/ProductDescriptionScreen/add_to_cart_provider.dart';
// import 'package:rpm/utils/app_colors.dart';
// import 'package:rpm/utils/app_images.dart';
// import 'package:rpm/controllers/services/session_manager.dart';
// import '../../PaymentSection/SuccessScreen/success_screen.dart';

// class AddToCartScreen extends StatefulWidget {
//   const AddToCartScreen({super.key});
//   @override
//   State<AddToCartScreen> createState() => _AddToCartScreenState();
// }

// class _AddToCartScreenState extends State<AddToCartScreen> {
//   bool _value = false;
//   bool _value1 = false;
//   @override
//   Widget build(BuildContext context) {
//     final countProvider = Provider.of<CountProvider>(context);
//     return Scaffold(
//       backgroundColor: Colors.white,
//       // appBar: AppBar(
//       //   backgroundColor: Colors.blue,
//       //   elevation: 0,
//       //   centerTitle: true,
//       //   // leading: IconButton(
//       //   //   onPressed: () {
//       //   //     Get.back();
//       //   //   },
//       //   //   icon: Icon(
//       //   //     Icons.arrow_back,
//       //   //     color: Colors.black,
//       //   //   ),
//       //   // ),
//       //   title: CustomText(
//       //     title: "Cart ",
//       //     fontWeight: FontWeight.w400,
//       //     fontSize: 18.sp,
//       //     color: AppColors.blackColor,
//       //   ),
//       //   // actions: [
//       //   //   IconButton(
//       //   //     onPressed: () {},
//       //   //     icon: Icon(
//       //   //       Icons.shopping_cart_outlined,
//       //   //       color: AppColors.blackColor,
//       //   //     ),
//       //   // )
//       //   // ],
//       // ),
//       body: SafeArea(
//         child: Padding(
//           padding: EdgeInsets.only(
//             left: 15.w,
//             right: 15.w,
//           ),
//           child: Column(
//             children: [
//               SizedBox(height: 15.w),
//               CustomText(
//                 title: "Cart ",
//                 fontWeight: FontWeight.w400,
//                 fontSize: 18.sp,
//                 color: AppColors.blackColor,
//               ),
//               SizedBox(height: 15.w),
//               Container(
//                 decoration: BoxDecoration(
//                   color: Color(0xffF8F8F8),
//                   borderRadius: BorderRadius.circular(3.95.r),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(20.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       CustomText(
//                         title: "Order Summery",
//                         fontSize: 15.50.sp,
//                         fontWeight: FontWeight.w400,
//                         color: AppColors.textColorB,
//                       ),
//                       SizedBox(
//                         height: 10.h,
//                       ),
//                       Divider(
//                         color: Color(0xffE8E8E8),
//                         thickness: 1,
//                       ),
//                       SizedBox(height: 15.h),
//                       StreamBuilder(
//                         stream: FirebaseFirestore.instance
//                             .collection('users')
//                             .doc(SessionController().userId)
//                             .snapshots(),
//                         builder:
//                             (BuildContext context, AsyncSnapshot snapshot) {
//                           if (snapshot.hasError) {
//                             return Text('Something went wrong');
//                           }

//                           if (snapshot.connectionState ==
//                               ConnectionState.waiting) {
//                             return Text("Loading");
//                           }

//                           return SizedBox(
//                             child: ListView.builder(
//                               shrinkWrap: true,
//                               itemCount: snapshot.data!.get('cart').length,
//                               physics: NeverScrollableScrollPhysics(),
//                               itemBuilder: (context, index) {
//                                 var snap = snapshot.data!.get('cart')[index];
//                                 return FutureBuilder(
//                                   future: FirebaseFirestore.instance
//                                       .collection('products')
//                                       .doc(snap)
//                                       .get(),
//                                   builder: (context, snapshot) {
//                                     var prodImage =
//                                         snapshot.data!.get('productImage')[0];
//                                     var prodPrice = snapshot.data!.get('price');
//                                     var prodTitle = snapshot.data!.get('title');
//                                     return Container(
//                                       child: Row(
//                                         children: [
//                                           Image.network(
//                                             prodImage,
//                                             height: 81.h,
//                                             width: 81.w,
//                                           ),
//                                           Padding(
//                                             padding:
//                                                 EdgeInsets.only(left: 10.w),
//                                             child: Column(
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.start,
//                                               children: [
//                                                 Row(
//                                                   mainAxisAlignment:
//                                                       MainAxisAlignment
//                                                           .spaceBetween,
//                                                   crossAxisAlignment:
//                                                       CrossAxisAlignment.start,
//                                                   children: [
//                                                     CustomText(
//                                                       title: prodTitle,
//                                                       fontSize: 16.50.sp,
//                                                       fontWeight:
//                                                           FontWeight.w400,
//                                                       color: AppColors
//                                                           .blackColor
//                                                           .withOpacity(.87),
//                                                     ),
//                                                     SizedBox(
//                                                       width: 100.w,
//                                                     ),
//                                                     GestureDetector(
//                                                       onTap: () {
//                                                         FirebaseFirestore
//                                                             .instance
//                                                             .collection('users')
//                                                             .doc(
//                                                                 SessionController()
//                                                                     .userId)
//                                                             .update({
//                                                           'cart': FieldValue
//                                                               .arrayRemove(
//                                                                   [snap])
//                                                         });
//                                                       },
//                                                       child: Icon(
//                                                         Icons.close,
//                                                         size: 15.sp,
//                                                         color: AppColors
//                                                             .blackColor
//                                                             .withOpacity(.38),
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 ),
//                                                 SizedBox(
//                                                   height: 8.h,
//                                                 ),
//                                                 SizedBox(
//                                                   child: CustomText(
//                                                     title: "\$ ${prodPrice}",
//                                                     fontSize: 15.50.sp,
//                                                     fontWeight: FontWeight.w400,
//                                                     color: Color(0xffD7D6D6),
//                                                   ),
//                                                 ),
//                                                 SizedBox(
//                                                   height: 10.h,
//                                                 ),
//                                                 Container(
//                                                   height: 26.h,
//                                                   width: 69.49.w,
//                                                   decoration: BoxDecoration(
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             4),
//                                                     border: Border.all(
//                                                         color: AppColors
//                                                             .greySeTextColor),
//                                                   ),
//                                                   child: Center(
//                                                     child: Row(
//                                                       mainAxisAlignment:
//                                                           MainAxisAlignment
//                                                               .spaceEvenly,
//                                                       children: [
//                                                         GestureDetector(
//                                                             onTap: () {
//                                                               countProvider
//                                                                   .decrement();
//                                                             },
//                                                             child: Icon(
//                                                                 Icons.remove,
//                                                                 size: 9.sp,
//                                                                 color: AppColors
//                                                                     .secondGTextColor)),
//                                                         CustomText(
//                                                           title: countProvider
//                                                               .count
//                                                               .toString(),
//                                                           fontWeight:
//                                                               FontWeight.w600,
//                                                           fontSize: 10.sp,
//                                                           color: AppColors
//                                                               .secondGTextColor,
//                                                         ),
//                                                         GestureDetector(
//                                                             onTap: () {
//                                                               countProvider
//                                                                   .increment();
//                                                             },
//                                                             child: Icon(
//                                                                 Icons.add,
//                                                                 size: 9.sp,
//                                                                 color: AppColors
//                                                                     .secondGTextColor)),
//                                                       ],
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           )
//                                         ],
//                                       ),
//                                     );
//                                   },
//                                 );
//                               },
//                             ),
//                           );
//                         },
//                       ),
//                       SizedBox(
//                         height: 15.h,
//                       ),
//                       Divider(
//                         color: Color(0xffE8E8E8),
//                         thickness: 1,
//                       ),
//                       SizedBox(
//                         height: 10.h,
//                       ),
//                       AddToCartRowText(
//                         title: "Delivery Charges",
//                         text: "\$${20.00}",
//                       ),
//                       SizedBox(
//                         height: 8.h,
//                       ),
//                       AddToCartRowText(
//                         title: "GST (19%)",
//                         text: "\$${40.00}",
//                       ),
//                       SizedBox(
//                         height: 8.h,
//                       ),
//                       AddToCartRowText(
//                         title: "Discount",
//                         text: "\$${10}%",
//                       ),
//                       SizedBox(
//                         height: 10.h,
//                       ),
//                       Divider(
//                         color: Color(0xffE8E8E8),
//                         thickness: 1,
//                       ),
//                       SizedBox(
//                         height: 10.h,
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           CustomText(
//                             title: "Total",
//                             fontSize: 12.50.sp,
//                             fontWeight: FontWeight.w400,
//                             color: AppColors.blackColor.withOpacity(.90),
//                           ),
//                           CustomText(
//                             title: "\$${2.15933}",
//                             fontSize: 12.50.sp,
//                             fontWeight: FontWeight.w400,
//                             color: AppColors.textColorB,
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 80.h,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   // GestureDetector(
//                   //   onTap: () {
//                   //     _showProceedDialog(context);
//                   //   },
//                   //   child: Container(
//                   //     width: 143,
//                   //     height: 38,
//                   //     decoration: BoxDecoration(
//                   //         boxShadow: [
//                   //           BoxShadow(
//                   //             color:
//                   //                 Colors.grey.withOpacity(0.35), // Shadow color
//                   //             spreadRadius: 2,
//                   //             blurRadius: 5,
//                   //             offset:
//                   //                 Offset(1, 3), // Offset in x and y direction
//                   //           ),
//                   //         ],
//                   //         borderRadius: BorderRadius.circular(10),
//                   //         color: Color(0xffF3F5F7)),
//                   //     child: Center(
//                   //       child: Text('Continue Shopping',
//                   //           style: TextStyle(
//                   //               fontSize: 11.sp,
//                   //               fontWeight: FontWeight.w400,
//                   //               color: AppColors.textFieldBorderColor)),
//                   //     ),
//                   //   ),
//                   // ),
//                   GestureDetector(
//                     onTap: () {
//                       // _showContinueDialog(context);
//                       Get.to(AddressScreen());
//                     },
//                     child: Container(
//                       width: 143,
//                       height: 38,
//                       decoration: BoxDecoration(
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black
//                                   .withOpacity(0.25), // Shadow color
//                               spreadRadius: 2,
//                               blurRadius: 5,
//                               offset:
//                                   Offset(0, 3), // Offset in x and y direction
//                             ),
//                           ],
//                           borderRadius: BorderRadius.circular(10),
//                           color: Color(0xff0061BF)),
//                       child: Center(
//                         child: Text('Proceed to Checkout',
//                             style: TextStyle(
//                                 fontSize: 11.sp,
//                                 fontWeight: FontWeight.w400,
//                                 color: Colors.white)),
//                       ),
//                     ),
//                   ),
//                 ],
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void _showContinueDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           backgroundColor: AppColors.textFieldBorderColor,
//           content: Form(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 CustomText(
//                   title: SessionController().name.toString(),
//                   fontSize: 15.50.sp,
//                   fontWeight: FontWeight.w400,
//                   color: AppColors.whiteColor,
//                 ),
//                 SizedBox(height: 10.h),
//                 CustomText(
//                   title: "What would  you Like To ",
//                   fontSize: 10.56.sp,
//                   fontWeight: FontWeight.w400,
//                   color: AppColors.whiteColor,
//                 ),
//                 SizedBox(height: 30.h),
//                 InkWell(
//                   onTap: () {
//                     // Get.to(AppNavigationBar());
//                   },
//                   child: Container(
//                     width: 289.w,
//                     height: 52.w,
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(17.r),
//                         color: AppColors.whiteColor),
//                     child: Row(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Image.asset(AppImages.addressImg),
//                         SizedBox(
//                           width: 10.w,
//                         ),
//                         CustomText(
//                           title: "Pick-Up Order",
//                           color: AppColors.blackColor,
//                           fontWeight: FontWeight.w400,
//                           fontSize: 15.85.sp,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 15.h),
//                 InkWell(
//                   onTap: () {
//                     Get.to(AddressScreen());
//                   },
//                   child: Container(
//                     width: 289.w,
//                     height: 52.w,
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(17.r),
//                         color: AppColors.whiteColor),
//                     child: Row(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Image.asset(AppImages.expressDeliveryImg),
//                         SizedBox(
//                           width: 10.w,
//                         ),
//                         CustomText(
//                           title: "Delivery     ",
//                           color: AppColors.blackColor,
//                           fontWeight: FontWeight.w400,
//                           fontSize: 15.85.sp,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 30.h),
//               ],
//             ),
//           ),
//           actions: [],
//         );
//       },
//     );
//   }

//   void _showProceedDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           backgroundColor: Color(0xffF7F7F7),
//           content: Form(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 CustomText(
//                   title: "Payment Methods",
//                   fontSize: 17.50.sp,
//                   fontWeight: FontWeight.w400,
//                   color: AppColors.blackColor.withOpacity(.87),
//                 ),
//                 SizedBox(height: 10.h),
//                 CustomText(
//                   title: "Select a payment method to continue.",
//                   fontSize: 11.56.sp,
//                   fontWeight: FontWeight.w400,
//                   color: AppColors.blackColor.withOpacity(.38),
//                 ),
//                 SizedBox(height: 30.h),
//                 InkWell(
//                   onTap: () {
//                     // Get.to(AppNavigationBar());
//                   },
//                   child: Container(
//                     width: 289.w,
//                     height: 52.w,
//                     padding: EdgeInsets.only(left: 20.w, right: 20.w),
//                     decoration: BoxDecoration(
//                         boxShadow: [
//                           BoxShadow(
//                             color:
//                                 Colors.grey.withOpacity(0.35), // Shadow color
//                             spreadRadius: 2,
//                             blurRadius: 5,
//                             offset: Offset(1, 3), // Offset in x and y direction
//                           ),
//                         ],
//                         borderRadius: BorderRadius.circular(17.r),
//                         color: AppColors.whiteColor),
//                     child: Row(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Image.asset(AppImages.creditCardImg),
//                         SizedBox(
//                           width: 10.w,
//                         ),
//                         CustomText(
//                           title: "Credit Card",
//                           color: AppColors.blackColor,
//                           fontWeight: FontWeight.w400,
//                           fontSize: 13.85.sp,
//                         ),
//                         Spacer(), // Initialize it as false initially
//                         InkWell(
//                           onTap: () {
//                             setState(() {
//                               _value = !_value;
//                             });
//                           },
//                           child: Container(
//                             decoration: BoxDecoration(
//                               shape: BoxShape.circle,
//                               color: _value == true ? Colors.blue : Colors.grey,
//                             ),
//                             child: Padding(
//                               padding: const EdgeInsets.all(2.0),
//                               child: _value == true
//                                   ? Icon(
//                                       Icons.check,
//                                       size: 15.0.sp,
//                                       color: Colors.white,
//                                     )
//                                   : Icon(
//                                       Icons.check_box_outline_blank,
//                                       size: 15.0,
//                                       color: _value == true
//                                           ? Colors.blue
//                                           : Colors.grey,
//                                     ),
//                             ),
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 15.h),
//                 InkWell(
//                   onTap: () {
//                     Get.to(AddressScreen());
//                   },
//                   child: Container(
//                     padding: EdgeInsets.only(left: 20.w, right: 20.w),
//                     width: 289.w,
//                     height: 52.w,
//                     decoration: BoxDecoration(
//                         boxShadow: [
//                           BoxShadow(
//                             color:
//                                 Colors.grey.withOpacity(0.35), // Shadow color
//                             spreadRadius: 2,
//                             blurRadius: 5,
//                             offset: Offset(1, 3), // Offset in x and y direction
//                           ),
//                         ],
//                         borderRadius: BorderRadius.circular(17.r),
//                         color: AppColors.whiteColor),
//                     child: Row(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         Image.asset(AppImages.moneyCashImg),
//                         SizedBox(
//                           width: 10.w,
//                         ),
//                         CustomText(
//                           title: "Cash",
//                           color: AppColors.blackColor,
//                           fontWeight: FontWeight.w400,
//                           fontSize: 13.85.sp,
//                         ),
//                         Spacer(),
//                         InkWell(
//                           onTap: () {
//                             setState(() {
//                               _value1 = !_value1;
//                             });
//                           },
//                           child: Container(
//                             decoration: BoxDecoration(
//                               shape: BoxShape.circle,
//                               color:
//                                   _value1 == true ? Colors.blue : Colors.grey,
//                             ),
//                             child: Padding(
//                               padding: const EdgeInsets.all(2.0),
//                               child: _value1 == true
//                                   ? Icon(
//                                       Icons.check,
//                                       size: 15.0.sp,
//                                       color: Colors.white,
//                                     )
//                                   : Icon(
//                                       Icons.check_box_outline_blank,
//                                       size: 15.0,
//                                       color: _value1 == true
//                                           ? Colors.blue
//                                           : Colors.grey,
//                                     ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 30.h),
//                 Row(
//                   children: [
//                     InkWell(
//                       onTap: () {
//                         Navigator.pop(context);
//                       },
//                       child: Container(
//                         padding: EdgeInsets.only(left: 20.w, right: 20.w),
//                         width: 100.w,
//                         height: 38.w,
//                         decoration: BoxDecoration(
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.grey
//                                     .withOpacity(0.35), // Shadow color
//                                 spreadRadius: 2,
//                                 blurRadius: 5,
//                                 offset:
//                                     Offset(1, 3), // Offset in x and y direction
//                               ),
//                             ],
//                             borderRadius: BorderRadius.circular(17.r),
//                             color: AppColors.whiteColor),
//                         child: Center(
//                           child: CustomText(
//                             title: "Cancel",
//                             color: AppColors.textFieldBorderColor,
//                             fontWeight: FontWeight.w400,
//                             fontSize: 13.85.sp,
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       width: 20.w,
//                     ),
//                     InkWell(
//                       onTap: () {
//                         Get.to(const SuccessScreen());
//                       },
//                       child: Container(
//                         // padding: EdgeInsets.only(left: 20.w,right: 20.w),
//                         width: 100.w,
//                         height: 38.w,
//                         decoration: BoxDecoration(
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.grey
//                                     .withOpacity(0.35), // Shadow color
//                                 spreadRadius: 2,
//                                 blurRadius: 5,
//                                 offset:
//                                     Offset(1, 3), // Offset in x and y direction
//                               ),
//                             ],
//                             borderRadius: BorderRadius.circular(17.r),
//                             color: AppColors.textFieldBorderColor),
//                         child: Center(
//                           child: CustomText(
//                             title: "Pay Now",
//                             color: AppColors.whiteColor,
//                             fontWeight: FontWeight.w400,
//                             fontSize: 13.85.sp,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 )
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
import 'dart:developer';

import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rpm/Views/driver_dashboard/PaymentSection/AddressScreem/home_address_screem.dart';
import 'package:rpm/Views/driver_dashboard/widgets/network_image_widget.dart';
import 'package:rpm/controllers/services/session_manager.dart';

// class CartScreen extends StatefulWidget {
//   @override
//   State<CartScreen> createState() => _CartScreenState();
// }

// class _CartScreenState extends State<CartScreen> {
//   double totalPrice = 0.0;

//   double tax = 0.0;

//   List<double> prices = [];
//   double _calculateTax() {
//     // Calculate tax logic goes here
//     // For example, assuming 10% tax rate
//     double subtotal = _calculateSubtotal();
//     return subtotal * 0.1;
//   }

//   void _updateTotalAndTax() {
//     tax = _calculateTax();
//     totalPrice = _calculateTotal();
//   }

//   double _calculateTotal() {
//     // Calculate total including tax logic goes here
//     double subtotal = _calculateSubtotal();
//     double calculatedTax = _calculateTax(); // Calculate tax separately

//     // Update tax for display
//     setState(() {
//       tax = calculatedTax;
//     });

//     return subtotal + calculatedTax;
//   }

//   double _calculateSubtotal() {
//     // Calculate subtotal logic goes here
//     double subtotal = 0;
//     for (var item in prices) {
//       subtotal += item;
//     }
//     return subtotal;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Cart'),
//         ),
//         body: Column(
//           children: [
//             StreamBuilder(
//                 stream: FirebaseFirestore.instance
//                     .collection('users')
//                     .doc(SessionController().userId)
//                     .snapshots(),
//                 builder: (BuildContext context, AsyncSnapshot snapshot) {
//                   if (snapshot.hasError) {
//                     return Text('Something went wrong');
//                   }

//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return Text("Loading");
//                   }
//                   // Extract cart data from the snapshot
//                   List<dynamic>? cartData = snapshot.data?.get('cart');

//                   return SizedBox(
//                       child: ListView.builder(
//                           shrinkWrap: true,
//                           itemCount: cartData?.length ?? 0,
//                           physics: NeverScrollableScrollPhysics(),
//                           itemBuilder: (context, index) {
//                             var snap = cartData![index];
//                             return FutureBuilder(
//                                 future: FirebaseFirestore.instance
//                                     .collection('products')
//                                     .doc(snap)
//                                     .get(),
//                                 builder: (context, productSnapshot) {
//                                   if (productSnapshot.connectionState ==
//                                           ConnectionState.waiting ||
//                                       !productSnapshot.hasData ||
//                                       productSnapshot.data!.data() == null) {
//                                     return Center(child: LoadingWidget());
//                                   }

//                                   var productData = productSnapshot.data!
//                                       .data()! as Map<String, dynamic>;
// // ... inside FutureBuilder
//                                   if (productSnapshot.connectionState ==
//                                       ConnectionState.done) {
//                                     var prodPrice = double.parse(
//                                         productData['price'] as String);
//                                     prices.add(prodPrice);
//                                     _updateTotalAndTax();
//                                   }

//                                   var prodImage =
//                                       productData['productImage'][0];
//                                   var prodPrice = double.parse(
//                                       productData['price'] as String);
//                                   // prices.add(prodPrice);
//                                   // _updateTotalAndTax(); // Update the total and tax whenever the price list changes

//                                   var prodTitle = productData['title'];

//                                   return ListTile(
//                                     leading: NetworkImageWidget(
//                                       height: 50,
//                                       width: 50,
//                                       imageUrl: prodImage.toString(),
//                                       borderRadius: 10,
//                                     ),
//                                     title: Text(prodTitle.toString()),
//                                     subtitle: Text('\$${prodPrice}'),
//                                   );
//                                 });
//                           }));
//                 }),
//             Spacer(),
//             Divider(),
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text('Tax:'),
//                       Text('\$${tax}'),
//                     ],
//                   ),
//                   SizedBox(height: 8.0),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text('Total:'),
//                       Text('\$${totalPrice}',
//                           style: TextStyle(fontWeight: FontWeight.bold)),
//                     ],
//                   ),
//                   SizedBox(height: 16.0),
//                   ElevatedButton(
//                     onPressed: () {
//                       // Implement checkout logic here
//                     },
//                     child: Text('Checkout'),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // double _calculateTax() {
//   //   // Calculate tax logic goes here
//   //   // For example, assuming 10% tax rate
//   //   double subtotal = _calculateSubtotal();
//   //   return subtotal * 0.1;
//   // }

//   // double _calculateTotal() {
//   //   // Calculate total including tax logic goes here
//   //   double subtotal = _calculateSubtotal();
//   //   double tax = _calculateTax();
//   //   return subtotal + tax;
//   // }

//   // double _calculateSubtotal() {
//   //   // Calculate subtotal logic goes here
//   //   double subtotal = 0;
//   //   for (var item in prices) {
//   //     subtotal += item;
//   //   }
//   //   return subtotal;
//   // }
// }
class CartScreen extends StatefulWidget {
  final bool showBackButton;

  const CartScreen({super.key, required this.showBackButton});
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  double totalPrice = 0.0;
  double tax = 0.0;
  List<double> prices = [];
  List<String> cartProductsIds = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Cart'),
          leading: widget.showBackButton
              ? IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ))
              : SizedBox.shrink(),
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(SessionController().userId)
              .snapshots(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("Loading");
            }

            // Extract cart data from the snapshot
            List<dynamic>? cartData = snapshot.data?.get('cart');

            if (cartData == null || cartData.isEmpty) {
              return Center(child: Text('Cart is empty'));
            }

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartData.length,
                    itemBuilder: (context, index) {
                      var snap = cartData[index];
                      return FutureBuilder(
                        future: FirebaseFirestore.instance
                            .collection('products')
                            .doc(snap)
                            .get(),
                        builder: (context, productSnapshot) {
                          if (productSnapshot.connectionState ==
                                  ConnectionState.waiting ||
                              !productSnapshot.hasData ||
                              productSnapshot.data!.data() == null) {
                            return Center(child: CircularProgressIndicator());
                          }

                          var productData = productSnapshot.data!.data()!
                              as Map<String, dynamic>;
                          log(productData.toString());
                          var prodPrice =
                              double.parse(productData['price'] as String);
                          var prodIds = productData['docId'];
                          prices.clear();
                          prices.add(prodPrice);
                          cartProductsIds.clear();
                          cartProductsIds.add(prodIds);

                          return Slidable(
                            // Specify a key if the Slidable is dismissible.
                            key: ValueKey(0),
                            endActionPane: ActionPane(
                              motion: ScrollMotion(),
                              children: [
                                SlidableAction(
                                  borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(12),
                                      topRight: Radius.circular(12)),
                                  flex: 2,
                                  onPressed: (context) {
                                    FirebaseFirestore.instance
                                        .collection('users')
                                        .doc(SessionController().userId)
                                        .update({
                                      'cart': FieldValue.arrayRemove([snap])
                                    });
                                    // setState(() {});
                                    didChangeDependencies();
                                  },
                                  backgroundColor: Colors.grey,
                                  foregroundColor: Colors.white,
                                  icon: Icons.group_remove_sharp,
                                  label: 'Remove from cart',
                                ),
                              ],
                            ),
                            child: ListTile(
                              leading: NetworkImageWidget(
                                  borderRadius: 20,
                                  imageUrl: productData['productImage'][0]),
                              title: Text(productData['title'].toString()),
                              subtitle: Text('\$$prodPrice'),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                Divider(),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Tax:'),
                          Text('\$$tax'),
                        ],
                      ),
                      SizedBox(height: 8.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Total:'),
                          Text(
                            '\$$totalPrice',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.0),
                      ElevatedButton(
                        onPressed: () {
                          // Implement checkout logic here
                          Get.to(AddressScreen(
                            totalPrice: totalPrice,
                            cartProductsIds: cartProductsIds,
                          ));
                        },
                        child: Text('Checkout'),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  double _calculateTax() {
    double subtotal = _calculateSubtotal();
    double tax = subtotal * 0.1; // Calculate the tax
    return tax
        .roundToDouble(); // Round the tax value to the nearest whole number and return it as a double
  }

  double _roundTax(double tax) {
    int roundedTax =
        tax.round(); // Round the tax value to the nearest whole number

    // Check if the decimal part is greater than or equal to 0.5 and adjust the rounded value accordingly
    if (tax - roundedTax >= 0.5) {
      roundedTax++; // Round up if the decimal part is 0.5 or more
    }

    return roundedTax.toDouble(); // Return the rounded tax value as a double
  }

// Other functions remain unchanged

  double _calculateTotal() {
    double subtotal = _calculateSubtotal();
    double calculatedTax = _calculateTax();
    return subtotal + calculatedTax;
  }

  double _calculateSubtotal() {
    double subtotal = 0;
    for (var item in prices) {
      subtotal += item;
    }
    return subtotal;
  }

  @override
  void didChangeDependencies() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      // Calculate totals after the frame is built
      Future.delayed(Duration(seconds: 1)).then((value) {
        tax = _calculateTax();
        totalPrice = _calculateTotal();
        print(tax);
        setState(() {});
      });
    });
    super.didChangeDependencies();
  }
}
