import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rpm/Views/driver_dashboard/ShopPart/AddToCartScreen/add_to_cart_screen.dart';
import 'package:rpm/Views/driver_dashboard/ShopPart/Auth/Components/big_text.dart';
import 'package:rpm/Views/driver_dashboard/ShopPart/ShopHomeScreen/ProductDescriptionScreen/product_description_screen.dart';
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
        title: Text('Products'),
        actions: [
          IconButton(
              onPressed: () {
                // Get.to(AddToCartScreen());
                Get.to(CartScreen(showBackButton: true));
              },
              icon: Icon(Icons.shopping_cart))
        ],
      ),
      body: Column(
        children: [
          TextFormField(
            controller: searchController,
            decoration: InputDecoration(
              hintText: 'Search',
              border: OutlineInputBorder(),
            ),
            onChanged: (value) => setState(() {}),
            style: TextStyle(color: Colors.blue), // Change input text color
          ),
          SizedBox(height: 10),
          StreamBuilder<QuerySnapshot>(
            stream:
                FirebaseFirestore.instance.collection('products').snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                            Image.asset(AppImages.pngWingImg),
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
                                  color: AppColors.blackColor.withOpacity(.50),
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                ),
                                SizedBox(width: 10),
                                CustomText(
                                  title: snap['price'],
                                  color: AppColors.blackColor.withOpacity(.50),
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
                                              .contains(
                                                  SessionController().userId)) {
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
                                              'favorite': FieldValue.arrayUnion(
                                                  [SessionController().userId])
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
                                        snapshot.data.get("favorite").contains(
                                                SessionController().userId)
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
    );
  }
}
