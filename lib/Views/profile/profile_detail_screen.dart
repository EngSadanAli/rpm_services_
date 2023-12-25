import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rpm/Views/driver_dashboard/ShopPart/Auth/LogInScreen/login_screen.dart';
import 'package:rpm/Views/driver_dashboard/widgets/round_button.dart';
import 'package:rpm/Views/profile/profile_screen.dart';
import 'package:rpm/controllers/services/session_manager.dart';
import 'package:rpm/utils/app_colors.dart';

class ProfileDetails extends StatelessWidget {
  final bool showBackButton;
  ProfileDetails({super.key, required this.showBackButton});
  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    // return;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Profile Details'),
          leading: showBackButton
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
        body: FutureBuilder<DocumentSnapshot>(
          future: users.doc(SessionController().userId).get(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text("Something went wrong");
            }

            if (snapshot.hasData && !snapshot.data!.exists) {
              return Text("Document does not exist");
            }

            if (snapshot.connectionState == ConnectionState.done) {
              Map<String, dynamic> data =
                  snapshot.data!.data() as Map<String, dynamic>;
              return Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                          '${data['profileImage']}'), // Replace with your image path
                      radius: 50,
                    ),
                    SizedBox(height: 30),
                    Text(
                      '${data['userName']}',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      '${data['email']}',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Role: ${data['role']}',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Phone: ${data['phone']}',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 3,
                      child: RoundButton(
                        borderRadius: 40,
                        title: "Edit Profile",
                        onPress: () {
                          Get.to(ProfileScreen(showBackButton: true));
                        },
                      ),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 3,
                      child: RoundButton(
                        borderRadius: 40,
                        title: "Logout",
                        onPress: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog.adaptive(
                                backgroundColor: AppColors.textFieldBorderColor,
                                title: Text('Logout'),
                                content:
                                    Text('Are you sure you want to logout?'),
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
                                              builder: (context) =>
                                                  LoginScreen(),
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
                        },
                      ),
                    ),
                    SizedBox(height: 80),
                  ],
                ),
              );
            }

            return Text("loading");
          },
        ),
      ),
    );
  }
}
