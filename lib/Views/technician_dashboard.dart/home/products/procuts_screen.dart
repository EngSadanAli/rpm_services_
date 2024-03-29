import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rpm/Views/driver_dashboard/ShopPart/AddToCartScreen/add_to_cart_screen.dart';
import 'package:rpm/Views/driver_dashboard/ShopPart/Auth/Components/big_text.dart';
import 'package:rpm/Views/driver_dashboard/ShopPart/ShopHomeScreen/ProductDescriptionScreen/product_description_screen.dart';
import 'package:rpm/Views/driver_dashboard/widgets/network_image_widget.dart';
import 'package:rpm/Views/technician_dashboard.dart/dashboard_screen.dart';
import 'package:rpm/controllers/services/session_manager.dart';
import 'package:rpm/utils/app_colors.dart';
import 'package:rpm/utils/app_images.dart';
import 'package:rpm/utils/utils.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Products',
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
            onPressed: () {
              // Get.to(AddToCartScreen());
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        actions: [
          IconButton(
              onPressed: () {
                // Get.to(AddToCartScreen());
                Get.to(CartScreen(showBackButton: true));
              },
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.blue,
              ))
        ],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
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
            // TextFormField(
            //   controller: searchController,
            //   decoration: InputDecoration(
            //     hintText: 'Search',
            //     border: OutlineInputBorder(),
            //   ),
            //   onChanged: (value) => setState(() {}),
            //   style: TextStyle(color: Colors.blue), // Change input text color
            // ),
            SizedBox(height: 10),
            StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('products').snapshots(),
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
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
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
                      padding: EdgeInsets.only(right: 16, left: 5),
                      child: GestureDetector(
                        onTap: () {
                          Get.to(ProductDescriptionScreen(snap: snap));
                        },
                        child: Container(
                          padding: EdgeInsets.only(top: 10, left: 8, right: 8),
                          height: 146,
                          width: 165,
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
                                offset:
                                    Offset(0, 4), // Offset in x and y direction
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              NetworkImageWidget(
                                  height: 80,
                                  width: 90,
                                  imageUrl: snap['productImage'][0]),
                              // Image.asset(AppImages.pngWingImg),
                              SizedBox(height: 4),
                              CustomText(
                                title: snap['title'],
                                color: AppColors.blackColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                              SizedBox(height: 6),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CustomText(
                                    title: "\$",
                                    color:
                                        AppColors.blackColor.withOpacity(.50),
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  SizedBox(width: 10),
                                  CustomText(
                                    title: snap['price'],
                                    color:
                                        AppColors.blackColor.withOpacity(.50),
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  // SizedBox(width: 10),
                                  // CustomText(
                                  //   title: "10% off",
                                  //   color: AppColors.redTextColor,
                                  //   fontSize: 10,
                                  //   fontWeight: FontWeight.w400,
                                  // ),
                                  Spacer(),
                                  StreamBuilder<DocumentSnapshot>(
                                    stream: FirebaseFirestore.instance
                                        .collection('products')
                                        .doc(snap['docId'])
                                        .snapshots(),
                                    builder: (context, AsyncSnapshot snapshot) {
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
                                                  .contains(SessionController()
                                                      .userId)
                                              ? Icons.favorite
                                              : Icons.favorite_border,
                                          size: 14,
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
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.grey.shade300, // Set the color as needed
        shape: const CircularNotchedRectangle(), // Use the shape you prefer
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          TechnicianDashboardScreen(initialIndex: 0),
                    ));
              },
            ),
            IconButton(
              icon: Icon(Icons.person),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          TechnicianDashboardScreen(initialIndex: 1),
                    ));
              },
            ),
          ],
        ),
      ),
    );
  }
}
