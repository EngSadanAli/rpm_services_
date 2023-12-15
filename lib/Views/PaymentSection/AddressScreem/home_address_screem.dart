import 'dart:convert';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:rpm/Views/PaymentSection/AddressScreem/widgets/textfield_widget.dart';
import 'package:rpm/Views/ShopPart/Auth/Components/big_text.dart';
import 'package:rpm/Views/Utils/app_colors.dart';
import 'package:rpm/controllers/order/order_controller.dart';

import 'package:http/http.dart' as http;
import 'package:rpm/controllers/services/session_manager.dart';
import 'package:rpm/utils/utils.dart';
import 'package:uuid/uuid.dart';

class AddressScreen extends StatelessWidget {
  AddressScreen({super.key});
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final cityController = TextEditingController();
  final addressController = TextEditingController();
  final phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic>? paymentIntentData;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
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
          title: "Address",
          fontWeight: FontWeight.w400,
          fontSize: 18.sp,
          color: AppColors.blackColor,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.shopping_cart_outlined,
              color: AppColors.blackColor,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.only(left: 16.w, right: 16.w),
            child: Consumer<OrderController>(
              builder: (context, value, child) => Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      title: "Delivery Address",
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.blackColor,
                    ),
                    SizedBox(height: 21.sp),
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: Color(0xffF8F8F8)),
                        child: Padding(
                          padding:
                              EdgeInsets.only(left: 4.w, right: 4.w, top: 20.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                title: "Full Name",
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                color: AppColors.blackColor,
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              AddressTextFieldWidget(
                                readOnly: false,
                                controller: nameController,
                                onFieldSubmittedValue: (newValue) {},
                                keyBoardType: TextInputType.text,
                                obscureText: false,
                                hint: 'Your Name',
                                onChange: (value) {},
                                validator: (value) {
                                  if (!GetUtils.isEmail(value!)) {
                                    return "Please enter Your Name";
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 37.h),
                              CustomText(
                                title: "Email Address",
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                color: AppColors.blackColor,
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              AddressTextFieldWidget(
                                readOnly: false,
                                controller: emailController,
                                onFieldSubmittedValue: (newValue) {},
                                keyBoardType: TextInputType.emailAddress,
                                obscureText: false,
                                hint: 'example@email.com',
                                onChange: (value) {},
                                validator: (value) {
                                  if (!GetUtils.isEmail(value!)) {
                                    return "Please enter Your Valid Email";
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 30.h),
                              Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomText(
                                        title: "City",
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.blackColor,
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      SizedBox(
                                        height: 45.h,
                                        width: 154.w,
                                        child: AddressTextFieldWidget(
                                          readOnly: false,
                                          controller: cityController,
                                          onFieldSubmittedValue: (newValue) {},
                                          keyBoardType: TextInputType.text,
                                          obscureText: false,
                                          hint: 'Your City',
                                          onChange: (value) {},
                                          validator: (value) {
                                            if (!GetUtils.isEmail(value!)) {
                                              return "Please enter Your City";
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomText(
                                        title: "Postal Address",
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.blackColor,
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      SizedBox(
                                        height: 45.h,
                                        width: 154.w,
                                        child: AddressTextFieldWidget(
                                          readOnly: false,
                                          controller: addressController,
                                          onFieldSubmittedValue: (newValue) {},
                                          keyBoardType: TextInputType.text,
                                          obscureText: false,
                                          hint: 'Your City',
                                          onChange: (value) {},
                                          validator: (value) {
                                            if (!GetUtils.isEmail(value!)) {
                                              return "Please enter Your Address";
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 24.h),
                              CustomText(
                                title: "Phone Number",
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                color: AppColors.blackColor,
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              AddressTextFieldWidget(
                                readOnly: false,
                                controller: phoneController,
                                onFieldSubmittedValue: (newValue) {},
                                keyBoardType: TextInputType.phone,
                                obscureText: false,
                                hint: 'Phone Number',
                                onChange: (value) {},
                                validator: (value) {
                                  if (!GetUtils.isEmail(value!)) {
                                    return "Please enter Your Phone Number";
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 60.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // InkWell(
                        //   onTap: (){
                        //     Get.to(AppNavigationBar());
                        //   },
                        //   child: Container(
                        //     width: 143,
                        //     height: 38,
                        //     decoration: BoxDecoration(
                        //         boxShadow: [
                        //           BoxShadow(
                        //             color: Colors.grey.withOpacity(0.35), // Shadow color
                        //             spreadRadius: 2,
                        //             blurRadius: 5,
                        //             offset: Offset(1, 3), // Offset in x and y direction
                        //           ),
                        //         ],
                        //         borderRadius: BorderRadius.circular(10),
                        //         color: Color(0xffF3F5F7)),
                        //     child: Center(
                        //       child: Text('Continue Shopping',
                        //           style: TextStyle(
                        //               fontSize: 11.sp,
                        //               fontWeight: FontWeight.w400,
                        //               color: AppColors.textFieldBorderColor)),
                        //     ),
                        //   ),
                        // ),
                        Expanded(child: SizedBox()),
                        GestureDetector(
                          onTap: () {
                            // _showReviewDialog(context);
                            // log('make============');
                            // makePayment('newBooking', context);
                            if (_formKey.currentState!.validate()) {
                              var docId = Uuid().v4();
                              FirebaseFirestore.instance
                                  .collection('orders')
                                  .doc(docId)
                                  .set({
                                docId: docId,
                                'name': nameController.text.trim(),
                                'email': emailController.text.trim(),
                                'city': cityController.text.trim(),
                                'postalCode': addressController.text.trim(),
                                'phone': phoneController.text.trim(),
                              }).then((value) {
                                FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(SessionController().userId)
                                    .update({'cart': []});
                                nameController.clear();
                                emailController.clear();
                                cityController.clear();
                                addressController.clear();
                                phoneController.clear();
                                navigator!.pop(context);
                                // navigator!.pop(context);
                                Utils.toastMessage('You Have Bought this item');
                              });
                            }
                          },
                          child: Container(
                            width: 143,
                            height: 38,
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black
                                        .withOpacity(0.25), // Shadow color
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: Offset(
                                        0, 3), // Offset in x and y direction
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(10),
                                color: Color(0xff0061BF)),
                            child: Center(
                              child: Text('Proceed to Checkout',
                                  style: TextStyle(
                                      fontSize: 11.sp,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white)),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )),
      ),
    );
  }

  Future<void> makePayment(newBooking, BuildContext context) async {
    //   try {
    //     paymentIntentData =
    //         await createPaymentIntent('20', 'USD'); //json.decode(response.body);
    //     // print('Response body==>${response.body.toString()}');
    //     await Stripe.instance
    //         .initPaymentSheet(
    //             paymentSheetParameters: SetupPaymentSheetParameters(
    //                 setupIntentClientSecret:
    //                     'sk_test_51N4hnjHdtYoR4UCNhBKf9oJ1DiNOUoBCE8YhDvCVhXk5iuexbD12EbnoFmAsT8FRdlP0cLQmLENxHTuTUuSZwbYd00pACXrK3C',
    //                 paymentIntentClientSecret:
    //                     paymentIntentData!['client_secret'],
    //                 //applePay: PaymentSheetApplePay.,
    //                 //googlePay: true,
    //                 //testEnv: true,
    //                 customFlow: true,
    //                 style: ThemeMode.system,
    //                 // merchantCountryCode: 'US',
    //                 merchantDisplayName: 'Kashif'))
    //         .then((value) {});

    //     ///now finally display payment sheeet
    //     displayPaymentSheet(newBooking, context);
    //   } catch (e, s) {
    //     print('Payment exception:$e$s');
    //   }
    // }

    // displayPaymentSheet(newBooking, context) async {
    //   try {
    //     await Stripe.instance
    //         .presentPaymentSheet(
    //             //       parameters: PresentPaymentSheetParameters(
    //             // clientSecret: paymentIntentData!['client_secret'],
    //             // confirmPayment: true,
    //             // )
    //             )
    //         .then((newValue) async {
    //       // await bookings.doc(widget.shopUid).set({
    //       //   'shopUid': widget.shopUid,
    //       //   'shopName': widget.shopName,
    //       //   'shopAddress': widget.shopAddress,
    //       //   'bookings': [SessionController().userId],
    //       // }).then((value) => bookings
    //       //         .doc(widget.shopUid)
    //       //         .collection('bookings')
    //       //         .doc(bookingDocId!)
    //       //         .set(newBooking.toJson())
    //       //         .then((value) async {
    //       //       Navigator.pop;
    //       //       Utils.flushBarDoneMessage("Booking Added", BuildContext, context);
    //       //       print("Booking Added");
    //       //     }).catchError((error) => print("Failed to add booking: $error")));

    //       print('payment intent' + paymentIntentData!['id'].toString());
    //       print(
    //           'payment intent' + paymentIntentData!['client_secret'].toString());
    //       print('payment intent' + paymentIntentData!['amount'].toString());
    //       print('payment intent' + paymentIntentData.toString());
    //       //orderPlaceApi(paymentIntentData!['id'].toString());

    //       Utils.toastMessage('paid successfully');

    //       paymentIntentData = null;
    //     }).onError((error, stackTrace) {
    //       print('Exception/DISPLAYPAYMENTSHEET==> $error $stackTrace');
    //     });
    //   } on StripeException catch (e) {
    //     print('Exception/DISPLAYPAYMENTSHEET==> $e');
    //     showDialog(
    //         context: context,
    //         builder: (_) => const AlertDialog(
    //               content: Text("Cancelled "),
    //             ));
    //   } catch (e) {
    //     print('$e');
    //   }
  }

  //  Future<Map<String, dynamic>>
  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount('20'),
        'currency': currency,
        'payment_method_types[]': 'card',
      };
      print(body);
      var response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          headers: {
            'Authorization': 'Bearer ' +
                'pk_test_51N4hnjHdtYoR4UCNa82ivYpDICcDZ77BXwEjS6b3j5qgJOldYBGBS2M9YnW8sPgV2nb3GQIIcFnxLhsE6OB3Dmke00EtcA7fe8',
            'Content-Type': 'application/x-www-form-urlencoded'
          });
      print('Create Intent reponse ===> ${response.body.toString()}');
      return jsonDecode(response.body);
    } catch (err) {
      print('err charging user: ${err.toString()}');
    }
  }

  calculateAmount(String amount) {
    final a = (int.parse(amount)) * 100;
    return a.toString();
  }
}
