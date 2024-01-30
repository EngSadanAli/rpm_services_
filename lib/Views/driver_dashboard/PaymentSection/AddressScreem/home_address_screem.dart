import 'dart:convert';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:rpm/Views/driver_dashboard/PaymentSection/AddressScreem/widgets/textfield_widget.dart';
import 'package:rpm/Views/driver_dashboard/ShopPart/Auth/Components/big_text.dart';
import 'package:rpm/Views/driver_dashboard/widgets/round_button.dart';
import 'package:rpm/utils/app_colors.dart';
import 'package:rpm/controllers/driver/order/order_controller.dart';

import 'package:http/http.dart' as http;
import 'package:rpm/controllers/services/session_manager.dart';
import 'package:rpm/utils/utils.dart';
import 'package:uuid/uuid.dart';

class AddressScreen extends StatefulWidget {
  final double totalPrice;
  final List<String> cartProductsIds;
  AddressScreen(
      {super.key, required this.totalPrice, required this.cartProductsIds});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final nameController = TextEditingController();

  final emailController = TextEditingController();

  final cityController = TextEditingController();

  final addressController = TextEditingController();

  final phoneController = TextEditingController();
  final stateController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  String selectedPaymentMethod =
      ''; // Class-level variable to store the selection
  Map<String, dynamic>? paymentIntentData;
  bool _loading = false;
  void _performPurchase() {
    // Ensure _loading state starts
    setState(() {
      _loading = true;
    });

    // Perform the purchase action
    // Example: Firestore update or network request
    var docId = Uuid().v4();
    FirebaseFirestore.instance.collection('orders').doc(docId).set({
      'docId': docId,
      'selectedPaymentMethod': selectedPaymentMethod,
      'customerId': SessionController().userId,
      'totalAmmount': widget.totalPrice,
      'cartProductsIds': widget.cartProductsIds,
      'name': nameController.text.trim(),
      'email': emailController.text.trim(),
      'city': cityController.text.trim(),
      'postalCode': addressController.text.trim(),
      'phone': phoneController.text.trim(),
      'state': stateController.text.trim(),
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
      setState(() => _loading = false);
      navigator!.pop(context);
      setState(() => _loading = false); // Stop the loading indicator
      // navigator!.pop(context);
      Utils.toastMessage('You Have Bought this item');
    });
    // After the action completes, stop the loading state
    setState(() {
      _loading = false;
    });
  }

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
                                  if (value == null || value.isEmpty) {
                                    return "Please enter a Name";
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
                                  if (value == null || value.isEmpty) {
                                    return "Please enter a valid email";
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
                                        height: 64.h,
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
                                            if (value == null ||
                                                value.isEmpty) {
                                              return "Please enter City";
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(width: 10.w),
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
                                        height: 64.h,
                                        width: 154.w,
                                        child: AddressTextFieldWidget(
                                          readOnly: false,
                                          controller: addressController,
                                          onFieldSubmittedValue: (newValue) {},
                                          keyBoardType: TextInputType.text,
                                          obscureText: false,
                                          hint: 'Postal Address',
                                          onChange: (value) {},
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return "Please enter Postal Address";
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
                                title: "State",
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                color: AppColors.blackColor,
                              ),
                              // SizedBox(
                              //   height: 5.h,
                              // ),
                              AddressTextFieldWidget(
                                readOnly: false,
                                controller: stateController,
                                onFieldSubmittedValue: (newValue) {},
                                keyBoardType: TextInputType.text,
                                obscureText: false,
                                hint: 'State',
                                onChange: (value) {},
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please enter State";
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              SizedBox(height: 24.h),
                              CustomText(
                                title: "Phone Number",
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                color: AppColors.blackColor,
                              ),
                              // SizedBox(
                              //   height: 5.h,
                              // ),
                              AddressTextFieldWidget(
                                readOnly: false,
                                controller: phoneController,
                                onFieldSubmittedValue: (newValue) {},
                                keyBoardType: TextInputType.phone,
                                obscureText: false,
                                hint: 'Phone Number',
                                onChange: (value) {},
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please enter Phone Number";
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
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
                        // GestureDetector(
                        //   child: Container(
                        //     width: 143,
                        //     height: 38,
                        //     decoration: BoxDecoration(
                        //         boxShadow: [
                        //           BoxShadow(
                        //             color: Colors.black
                        //                 .withOpacity(0.25), // Shadow color
                        //             spreadRadius: 2,
                        //             blurRadius: 5,
                        //             offset: Offset(
                        //                 0, 3), // Offset in x and y direction
                        //           ),
                        //         ],
                        //         borderRadius: BorderRadius.circular(10),
                        //         color: Color(0xff0061BF)),
                        //     child: Center(
                        //       child: Text('Proceed to Checkout',
                        //           style: TextStyle(
                        //               fontSize: 11.sp,
                        //               fontWeight: FontWeight.w400,
                        //               color: Colors.white)),
                        //     ),
                        //   ),
                        // ),
                        SizedBox(
                          width: MediaQuery.of(context).size.height / 5,
                          child: RoundButton(
                            loading: _loading,
                            title: 'Proceed to Checkout',
                            onPress: () {
                              // _showReviewDialog(context);
                              // log('make============');
                              // makePayment('newBooking', context);
                              if (_formKey.currentState!.validate()) {
                                setState(() => _loading = true);
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return StatefulBuilder(builder:
                                        (BuildContext context,
                                            StateSetter setState) {
                                      return AlertDialog(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(32.0))),
                                        contentPadding: EdgeInsets.all(30.0),
                                        backgroundColor: Colors.white,
                                        title: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Payment Methods',
                                              style: TextStyle(
                                                color: Colors.black.withOpacity(
                                                    0.8700000047683716),
                                                fontSize: 17.05,
                                                fontFamily: 'Futura Hv BT',
                                                fontWeight: FontWeight.w400,
                                                height: 0,
                                              ),
                                            ),
                                            SizedBox(height: 11),
                                            Text(
                                              'Select a payment method to continue.',
                                              style: TextStyle(
                                                color: Colors.black.withOpacity(
                                                    0.3799999952316284),
                                                fontSize: 11.37,
                                                fontFamily: 'Futura Md BT',
                                                fontWeight: FontWeight.w400,
                                                height: 0,
                                                letterSpacing: -0.11,
                                              ),
                                            )
                                          ],
                                        ),
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    selectedPaymentMethod =
                                                        'Credit Card';
                                                  });
                                                },
                                                child:

                                                    //  ListTile(
                                                    //   tileColor:
                                                    // selectedPaymentMethod ==
                                                    //         'Credit Card'
                                                    //     ? Colors.blue
                                                    //     : Colors.transparent,
                                                    //   title: Text(
                                                    //     'Credit Card',
                                                    //     style: TextStyle(
                                                    //         color: Colors.black),
                                                    //   ),
                                                    // ),
                                                    Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 20),
                                                  width: double.infinity,
                                                  height: 56.83,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      border: Border.all(
                                                        color:
                                                            Color(0x7F000000),
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20)),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Image.asset(
                                                              'assets/images/credit-card.png'),
                                                          SizedBox(width: 20),
                                                          Text(
                                                            'Credit Card',
                                                            style: TextStyle(
                                                              color: Colors
                                                                  .black
                                                                  .withOpacity(
                                                                      0.6000000238418579),
                                                              fontSize: 13.26,
                                                              fontFamily:
                                                                  'Futura Hv BT',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              height: 0.19,
                                                              letterSpacing:
                                                                  -0.13,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Icon(
                                                        Icons
                                                            .check_circle_outline_outlined,
                                                        color:
                                                            selectedPaymentMethod ==
                                                                    'Credit Card'
                                                                ? Colors.blue
                                                                : Colors
                                                                    .transparent,
                                                      ),
                                                    ],
                                                  ),
                                                )),
                                            SizedBox(height: 10),
                                            GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    selectedPaymentMethod =
                                                        'Cash on Delivery';
                                                  });
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 20),
                                                  width: double.infinity,
                                                  height: 56.83,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      border: Border.all(
                                                        color:
                                                            Color(0x7F000000),
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20)),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Image.asset(
                                                              'assets/images/money_cash_img.png'),
                                                          SizedBox(width: 20),
                                                          Text(
                                                            'Cash',
                                                            style: TextStyle(
                                                              color: Colors
                                                                  .black
                                                                  .withOpacity(
                                                                      0.6000000238418579),
                                                              fontSize: 13.26,
                                                              fontFamily:
                                                                  'Futura Hv BT',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              height: 0.19,
                                                              letterSpacing:
                                                                  -0.13,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Icon(
                                                        Icons
                                                            .check_circle_outline_outlined,
                                                        color: selectedPaymentMethod ==
                                                                'Cash on Delivery'
                                                            ? Colors.blue
                                                            : Colors
                                                                .transparent,
                                                      ),
                                                    ],
                                                  ),
                                                )),
                                          ],
                                        ),
                                        actions: [
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                3,
                                            child: RoundButton(
                                              textColor: Colors.blue,
                                              buttonColor: Colors.grey.shade100,
                                              title: 'Cancel',
                                              onPress: () {
                                                setState(() {
                                                  _loading = false;
                                                });
                                                Navigator.of(context)
                                                    .pop(); // Close the dialog on cancel
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ),
                                          // TextButton(
                                          //   onPressed: () {
                                          //     setState(() {
                                          //       _loading = false;
                                          //     });
                                          //     Navigator.of(context)
                                          //         .pop(); // Close the dialog on cancel
                                          //     // Navigator.of(context).pop();
                                          //   },
                                          //   child: Text('Cancel'),
                                          // ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                3,
                                            child: RoundButton(
                                              // textColor: Colors.blue,
                                              // buttonColor:
                                              //     Colors.white.withOpacity(.5),
                                              title: 'Proceed',
                                              onPress: () {
                                                // Proceed with the selected payment method
                                                if (selectedPaymentMethod
                                                    .isNotEmpty) {
                                                  // Perform actions based on the selected payment method
                                                  // For example, trigger the order placement

                                                  _performPurchase();

                                                  Navigator.of(context)
                                                      .pop(); // Close the dialog
                                                } else {
                                                  // Show a message that a payment method needs to be selected
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      content: Text(
                                                          'Please select a payment method.'),
                                                    ),
                                                  );
                                                }
                                              },
                                            ),
                                          ),
                                          // ElevatedButton(
                                          //   onPressed: () {
                                          //     // Proceed with the selected payment method
                                          //     if (selectedPaymentMethod
                                          //         .isNotEmpty) {
                                          //       // Perform actions based on the selected payment method
                                          //       // For example, trigger the order placement

                                          //       _performPurchase();

                                          //       Navigator.of(context)
                                          //           .pop(); // Close the dialog
                                          //     } else {
                                          //       // Show a message that a payment method needs to be selected
                                          //       ScaffoldMessenger.of(context)
                                          //           .showSnackBar(
                                          //         SnackBar(
                                          //           content: Text(
                                          //               'Please select a payment method.'),
                                          //         ),
                                          //       );
                                          //     }
                                          //   },
                                          //   child: Text('Proceed'),
                                          // ),
                                        ],
                                      );
                                    });
                                  },
                                );
                              }
                            },
                          ),
                        )
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
