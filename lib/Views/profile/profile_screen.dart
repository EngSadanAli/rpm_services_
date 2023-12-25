import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:rpm/utils/app_colors.dart';
import 'package:rpm/controllers/profile_controller.dart';
import 'package:rpm/controllers/services/session_manager.dart';
import 'package:rpm/Views/driver_dashboard/widgets/network_image_widget.dart';
import 'package:rpm/Views/driver_dashboard/widgets/profile_picture_widget.dart';

class ProfileScreen extends StatefulWidget {
  final bool showBackButton;
  const ProfileScreen({super.key, required this.showBackButton});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: widget.showBackButton
              ? IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(
                    Icons.arrow_back_rounded,
                    color: AppColors.blackColor,
                  ))
              : SizedBox.shrink(),
        ),
        body: SingleChildScrollView(
          child: Consumer<ProfileController>(
              builder: (context, value, child) => StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .where('uid', isEqualTo: SessionController().userId)
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Text('Something went wrong');
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: LoadingWidget());
                      }
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Edit Profile',
                              style: TextStyle(
                                color: Colors.black
                                    .withOpacity(0.8700000047683716),
                                fontSize: 24,
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.w700,
                                height: 0,
                                letterSpacing: -0.30,
                              ),
                            ),
                            Text(
                              'Update Your Profile',
                              style: TextStyle(
                                color: Colors.black
                                    .withOpacity(0.3799999952316284),
                                fontSize: 16,
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.w500,
                                height: 0,
                                letterSpacing: -0.30,
                              ),
                            ),
                            SizedBox(height: 28.9),
                            Container(
                              padding: EdgeInsets.all(20),
                              width: double.infinity,
                              height: 235.83,
                              decoration: ShapeDecoration(
                                color: Color(0xFF0061BF),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.94),
                                ),
                              ),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Profile Picture',
                                      style: TextStyle(
                                        color: Colors.white
                                            .withOpacity(0.8500000238418579),
                                        fontSize: 17.05,
                                        fontFamily: 'Nunito',
                                        fontWeight: FontWeight.w600,
                                        height: 0,
                                        letterSpacing: -0.28,
                                      ),
                                    ),
                                    SizedBox(height: 28),
                                    Center(
                                      child: ProfilePictureWidget(
                                        snapshot: snapshot,
                                        userProfileUid: SessionController()
                                            .userId
                                            .toString(),
                                      ),
                                    ),
                                    SizedBox(height: 28),
                                    Center(
                                      child: Text(
                                        'Tap to Add your Profile\nPicture.  ',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white
                                              .withOpacity(0.6200000047683716),
                                          fontSize: 15.15,
                                          fontFamily: 'Nunito',
                                          fontWeight: FontWeight.w500,
                                          height: 0,
                                          letterSpacing: -0.28,
                                        ),
                                      ),
                                    )
                                  ]),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: ListTile(
                                onTap: () {
                                  value.updateDialogAlert(
                                      context,
                                      snapshot.data!.docs[0]['userName']
                                          .toString(),
                                      'userName',
                                      TextInputType.name);
                                },
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                tileColor: Color(0xff0FF0061BF),
                                leading: Icon(Icons.person),
                                title: Text(
                                  snapshot.data!.docs[0]['userName'].toString(),
                                  style:
                                      Theme.of(context).textTheme.bodyMedium!,
                                ),
                                trailing: Icon(Icons.edit),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: ListTile(
                                onTap: () {},
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                tileColor: Color(0xff0FF0061BF),
                                leading: Icon(Icons.person),
                                title: Text(
                                  snapshot.data!.docs[0]['email'].toString(),
                                  style:
                                      Theme.of(context).textTheme.bodyMedium!,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: ListTile(
                                onTap: () {
                                  value.updateDialogAlert(
                                      context,
                                      snapshot.data!.docs[0]['phone']
                                          .toString(),
                                      'phone',
                                      TextInputType.number);
                                },
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                tileColor: Color(0xff0FF0061BF),
                                leading: Icon(Icons.person),
                                title: Text(
                                  snapshot.data!.docs[0]['phone'].toString() ==
                                          ''
                                      ? '##########'
                                      : snapshot.data!.docs[0]['phone']
                                          .toString(),
                                  style:
                                      Theme.of(context).textTheme.bodyMedium!,
                                ),
                                trailing: Icon(Icons.edit),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  )),
        ));
  }
}
