// ignore_for_file: use_build_context_synchronously
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rpm/controllers/services/session_manager.dart';
import 'package:rpm/utils/utils.dart';
import 'package:rpm/widgets/select_screen_widget.dart';

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
        if (documentSnapshot.get('role') == 'driver') {
          Get.to(const SelectionScreen());
          SessionController().name = documentSnapshot.get('userName');
          SessionController().email = documentSnapshot.get('email');
          SessionController().profilePic = documentSnapshot.get('profileImage');
          SessionController().phone = documentSnapshot.get('phone');
          SessionController().role = documentSnapshot.get('role');
          SessionController().userId = documentSnapshot.get('uid');

          // Navigator.pushNamedAndRemoveUntil(
          //     context, RouteName.barberdashboardView, (route) => false);
          Utils.flushBarDoneMessage("login successfully", context);
        }
        Utils.flushBarDoneMessage("login successfully", context);
      } else {
        if (kDebugMode) {
          print('Document does not exist on the database');
        }
      }
    });
  }
}
