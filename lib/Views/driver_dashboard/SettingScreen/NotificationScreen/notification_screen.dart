import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rpm/controllers/services/session_manager.dart';
import 'package:rpm/Views/driver_dashboard/widgets/network_image_widget.dart';

import '../../ShopPart/Auth/Components/big_text.dart';
import '../../../../utils/app_colors.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  // bool switchValue = false;
  // bool switchValue1 = false;
  // bool switchValue2 = false;
  // bool switchValue3 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppColors.whiteColor,
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
          title: "Notification",
          fontWeight: FontWeight.w700,
          fontSize: 18.sp,
          color: AppColors.blackColor.withOpacity(.87),
        ),
      ),
      // body: ListView.builder(
      //   itemCount: 100,
      //   itemBuilder: (context, index) {
      //     return ListTile(
      //       title: Text(
      //         'Engine compaint',
      //         style: TextStyle(color: Colors.black),
      //       ),
      //       subtitle: Text(
      //         'Pending',
      //         style: TextStyle(color: Colors.black),
      //       ),
      //     );
      //   },
      // ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('service')
            .where('uid', isEqualTo: SessionController().userId)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: LoadingWidget());
          }
          if (snapshot.data!.docs.length == 0) {
            return Center(
                child: Text(
              'No Data',
              style: TextStyle(color: AppColors.blackColor),
            ));
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var data = snapshot.data!.docs[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  tileColor: Colors.grey,
                  title: Text(
                    "Vin :: " + data['vin'],
                    style: TextStyle(color: Colors.black),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Status",
                            style: TextStyle(color: Colors.black),
                          ),
                          Text(
                            data['status'],
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Driver Contact",
                            style: TextStyle(color: Colors.black),
                          ),
                          Text(
                            data['phone'],
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Driver Name",
                            style: TextStyle(color: Colors.black),
                          ),
                          Text(
                            data['name'],
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
