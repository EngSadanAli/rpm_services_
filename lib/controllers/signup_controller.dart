import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rpm/Views/ShopPart/Auth/LogInScreen/login_screen.dart';
import 'package:rpm/controllers/services/session_manager.dart';
import 'package:rpm/models/user_model.dart';
import 'package:rpm/utils/utils.dart';

class SignupController with ChangeNotifier {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;
  // status lodaing
  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  // sign up func
  void signUpUser(
    BuildContext context,
    String username,
    String email,
    String password,
    String role,
  ) async {
    setLoading(true);
    try {
      // ignore: unused_local_variable
      auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        UserModel user = UserModel(
          userName: username,
          email: value.user!.email,
          profileImage: '',
          role: role,
          uid: value.user!.uid,
          phone: '',
        );
        SessionController().userId = value.user!.uid.toString();
        SessionController().email = value.user!.email.toString();
        SessionController().name = username.toString();
        SessionController().phone = '';
        SessionController().profilePic = value.user!.uid.toString();
        SessionController().role = role.toString();
        db.collection('users').doc(user.uid).set(user.toJson());
        setLoading(false);
        if (SessionController().role == 'driver') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
          );
        }
        await Utils.toastMessage("Account created successfully");
      }).onError((error, stackTrace) {
        setLoading(false);
        Utils.toastMessage(error.toString());
        //
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

  @override
  notifyListeners();
}
