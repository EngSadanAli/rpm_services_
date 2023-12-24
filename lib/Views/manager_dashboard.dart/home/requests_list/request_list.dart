import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rpm/Views/manager_dashboard.dart/home/service_detail/service_detail_screen.dart';
import 'package:rpm/Views/technician_dashboard.dart/home/service_detail/service_detail_screen.dart';
import 'package:rpm/controllers/services/session_manager.dart';
import 'package:rpm/utils/app_colors.dart';
import 'package:rpm/utils/app_images.dart';
import 'package:intl/intl.dart';

class RequestListScreen extends StatefulWidget {
  const RequestListScreen({super.key});

  @override
  State<RequestListScreen> createState() => _RequestListScreenState();
}

class _RequestListScreenState extends State<RequestListScreen> {
  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(
                Icons.arrow_back,
                color: AppColors.blackColor,
              )),
          backgroundColor: Colors.grey.shade300,
          elevation: 0,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 40),
              Image.asset(AppImages.appLogo, height: 130),
              SizedBox(height: 20),
              Text(
                'OPEN SERVICE CALLS',
                style: TextStyle(
                    color: AppColors.blackColor,
                    fontSize: 24,
                    fontWeight: FontWeight.w700),
              ),
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('service')
                      .where('assignedTo', isEqualTo: '')
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
                    // final List<DocumentSnapshot> filteredProducts =
                    //     snapshot.data!.docs.where((product) {
                    //   final title = product['vin'].toString().toLowerCase();
                    //   final searchText = searchController.text.toLowerCase();
                    //   return title.contains(searchText);
                    // }).toList();

                    if (snapshot.data!.docs.isEmpty) {
                      return Text('No matching products found');
                    }
                    return Expanded(
                      child: ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        //  filteredProducts.length,
                        itemBuilder: (context, index) {
                          var snap = snapshot.data!.docs[index];
                          DateTime inputDate =
                              DateTime.parse(snap['selectedDate']);

                          String formattedDate =
                              DateFormat('dd MMM yyyy').format(inputDate);
                          return Padding(
                            padding: const EdgeInsets.all(10),
                            child: ListTile(
                              onTap: () {
                                Get.to(ManagerServicedetailScreen(
                                  snap: snap,
                                ));
                              },
                              tileColor: Colors.grey.shade300,
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    formattedDate,
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  Text(
                                    snap['selectedTime'],
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ],
                              ),
                              subtitle: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    snap['name'],
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  Text(
                                    snap['complaint'],
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  })
            ],
          ),
        ));
  }
}
