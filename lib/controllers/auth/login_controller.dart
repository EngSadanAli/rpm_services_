// ignore_for_file: use_build_context_synchronously
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:get/get.dart';
import 'package:rpm/Views/manager_dashboard.dart/manager_dashboard.dart';
import 'package:rpm/Views/technician_dashboard.dart/dashboard_screen.dart';
import 'package:rpm/controllers/services/session_manager.dart';
import 'package:rpm/models/user_model.dart';
import 'package:rpm/utils/utils.dart';
import 'package:rpm/Views/driver_dashboard/widgets/select_screen_widget.dart';

class LoginController with ChangeNotifier {
  FirebaseAuth auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance.collection('users');
  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  // email login
  Future login(BuildContext context, String email, String password) async {
    setLoading(true);
    try {
      auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        SessionController().userId = value.user!.uid.toString();
        setLoading(false);
        route(context);
        setLoading(false);
      }).onError((error, stackTrace) {
        setLoading(false);
        Utils.toastMessage(error.toString());
      });
    } catch (e) {
      setLoading(false);
      Utils.toastMessage(e.toString());
    }
  }

  // route checking
  void route(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    // ignore: unused_local_variable
    var kk = FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) async {
      if (documentSnapshot.exists) {
        final prefs = await SharedPreferences.getInstance();
        SessionController().name = documentSnapshot.get('userName');
        SessionController().email = documentSnapshot.get('email');
        SessionController().profilePic = documentSnapshot.get('profileImage');
        SessionController().phone = documentSnapshot.get('phone');
        SessionController().role = documentSnapshot.get('role');
        SessionController().userId = documentSnapshot.get('uid');
        if (documentSnapshot.get('role') == 'Driver') {
          await prefs.setString('role', 'Driver');
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => SelectionScreen()),
              (route) => false);
          Utils.flushBarDoneMessage("login successfully", context);
        }
        if (documentSnapshot.get('role') == 'Manager') {
          await prefs.setString('role', 'Manager');
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => ManagerDashboardScreen()),
              (route) => false);
          Utils.flushBarDoneMessage("login successfully", context);
        }
        if (documentSnapshot.get('role') == 'Mechanic') {
          await prefs.setString('role', 'Mechanic');
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => TechnicianDashboardScreen()),
              (route) => false);
          Utils.flushBarDoneMessage("login successfully", context);
        }
        // Utils.flushBarDoneMessage("login successfully", context);
      } else {
        if (kDebugMode) {
          print('Document does not exist on the database');
        }
      }
    });
  }

  //for checking user exists or not?
  static Future<bool> userExists() async {
    return (await FirebaseFirestore.instance
            .collection('User')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .get())
        .exists;
  }

  // google sig  in
  Future<void> loginWithGoogle(BuildContext context) async {
    setLoading(true);
    try {
      //To check internet connectivity
      await InternetAddress.lookup('firebase.google.com');
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      if (googleAuth == null) {
        return;
      }
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await FirebaseAuth.instance
          .signInWithCredential(credential)
          .then((value) async {
        SessionController().userId = value.user!.uid.toString();
        if (await userExists()) {
          Get.to(const SelectionScreen());
          Utils.toastMessage("User login successfully");
          setLoading(false);
        } else {
          UserModel user = UserModel(
            userName: value.user!.displayName,
            email: value.user!.email,
            profileImage: value.user!.photoURL,
            role: 'driver',
            uid: value.user!.uid,
            phone: '',
            cart: [],
          );
          SessionController().userId = value.user!.uid.toString();
          SessionController().email = value.user!.email.toString();
          SessionController().name = value.user!.displayName.toString();
          SessionController().phone = '';
          SessionController().profilePic = value.user!.uid.toString();
          SessionController().role = 'driver'.toString();
          FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .set(user.toJson());
          setLoading(false);
          if (SessionController().role == 'driver') {
            Get.to(const SelectionScreen());
          }
          Utils.flushBarDoneMessage("Account created successfully", context);
        }
      }).then((value) {
        Get.to(const SelectionScreen());
        Utils.flushBarDoneMessage("User login successfully", context);
        setLoading(false);
      }).onError((error, stackTrace) {
        setLoading(false);
        Utils.toastMessage(error.toString());
      });
    } catch (e) {
      setLoading(false);
      Utils.toastMessage(e.toString());
      if (kDebugMode) {
        print("Error: $e");
      }
      return;
    }
  }
}
