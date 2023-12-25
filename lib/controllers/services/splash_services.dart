import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rpm/Views/driver_dashboard/ShopPart/Auth/OnboardScreen/onboard_screen.dart';
import 'package:rpm/Views/driver_dashboard/widgets/select_screen_widget.dart';
import 'package:rpm/Views/manager_dashboard.dart/manager_dashboard.dart';
import 'package:rpm/Views/technician_dashboard.dart/dashboard_screen.dart';
import 'package:rpm/controllers/services/session_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashServices {
  void isLogin(BuildContext context) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    final prefs = await SharedPreferences.getInstance();
    final String? role = prefs.getString('role');
    final user = auth.currentUser;
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .get()
          .then((value) async {
        SessionController().name = value.get('userName');
        SessionController().email = value.get('email');
        SessionController().profilePic = value.get('profileImage');
        SessionController().phone = value.get('phone');
        SessionController().role = value.get('role');
        SessionController().userId = value.get('uid');

        if (user != null && role == 'Driver') {
          SessionController().userId = user.uid.toString();

          await prefs.setString('role', 'Driver');
          Timer(
            const Duration(seconds: 2),
            () => Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => SelectionScreen()),
                (route) => false),
          );
        } else if (user != null && role == 'Manager') {
          SessionController().userId = user.uid.toString();
          await prefs.setString('role', 'Manager');
          Timer(
            const Duration(seconds: 2),
            () => Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => ManagerDashboardScreen()),
                (route) => false),
          );
        } else if (user != null && role == 'Mechanic') {
          SessionController().userId = user.uid.toString();
          await prefs.setString('role', 'Mechanic');
          Timer(
            const Duration(seconds: 2),
            () => Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => TechnicianDashboardScreen()),
                (route) => false),
          );
        } else {
          Timer(const Duration(seconds: 2), () async {
            Get.to(OnboardScreen());
            // Get.to( LoginScreen());
          });
        }
      });
    } catch (e) {
      Get.to(OnboardScreen());
    }
  }
}
