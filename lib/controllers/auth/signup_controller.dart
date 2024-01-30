import 'dart:core';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rpm/Views/driver_dashboard/ShopPart/Auth/LogInScreen/login_screen.dart';
import 'package:rpm/controllers/profile_controller.dart';
import 'package:rpm/controllers/services/session_manager.dart';
import 'package:rpm/models/user_model.dart';
import 'package:rpm/utils/utils.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class SignupController with ChangeNotifier {
  final ProfileRepository _repository = ProfileRepository();

  CollectionReference ref = FirebaseFirestore.instance.collection('users');
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  final picker = ImagePicker();

  XFile? _image;
  XFile? get image => _image;

  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future pickImage(BuildContext context, ImageSource imageSource) async {
    final pickedFile =
        await picker.pickImage(source: imageSource, imageQuality: 100);

    if (pickedFile != null) {
      _image = XFile(pickedFile.path);
      // ignore: use_build_context_synchronously
      // uploadImage(context);
      notifyListeners();
    }
  }

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;
  // status lodaing
  // bool _loading = false;
  // bool get loading => _loading;
  // setLoading(bool value) {
  //   _loading = value;
  //   notifyListeners();
  // }

  // sign up func
  void signUpUser(
    BuildContext context,
    String username,
    String email,
    String password,
    String role,
    String phone,
  ) async {
    if (_image != null) {
      setLoading(true);
      try {
        // ignore: unused_local_variable
        auth
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) async {
          if (_image != null) {
            // ignore: use_build_context_synchronously
            // uploadImage(context);
            firebase_storage.Reference storageRef = firebase_storage
                .FirebaseStorage.instance
                .ref('/profileImage/profileImage${value.user!.uid}');

            firebase_storage.UploadTask uploadTask =
                storageRef.putFile(File(image!.path).absolute);

            await Future.value(uploadTask);
            final newUrl = await storageRef.getDownloadURL();
            // await _repository
            //     .updateUserProfileUrl(
            //         SessionController().userId.toString(), newUrl)
            //     .then((value) {
            //   SessionController().profilePic = newUrl;
            //   Utils.toastMessage('Profile update');
            //   setLoading(false);
            //   _image = null;

            UserModel user = UserModel(
              userName: username,
              email: value.user!.email,
              profileImage: newUrl,
              role: role,
              uid: value.user!.uid,
              phone: phone,
              cart: [],
            );
            SessionController().userId = value.user!.uid.toString();
            SessionController().email = value.user!.email.toString();
            SessionController().name = username.toString();
            SessionController().phone = phone;
            SessionController().profilePic = newUrl.toString();
            SessionController().role = role.toString();
            await db.collection('users').doc(user.uid).set(user.toJson());
            setLoading(false);
            if (SessionController().role == 'Driver') {
              _image == null;
              notifyListeners();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            }
            if (SessionController().role == 'Manager') {
              _image == null;
              notifyListeners();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            }
            if (SessionController().role == 'Mechanic') {
              _image == null;
              notifyListeners();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            }
          }
          // if (_image == null) {
          //   Utils.flushBarErrorMessage(
          //       'Please add an image', BuildContext, context);
          // }

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
    } else if (_image == null) {
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
            phone: phone,
            cart: [],
          );
          SessionController().userId = value.user!.uid.toString();
          SessionController().email = value.user!.email.toString();
          SessionController().name = username.toString();
          SessionController().phone = phone;
          SessionController().profilePic = '';
          SessionController().role = role.toString();
          await db.collection('users').doc(user.uid).set(user.toJson());
          setLoading(false);
          if (SessionController().role == 'Driver') {
            _image == null;
            notifyListeners();
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
            );
          }
          if (SessionController().role == 'Manager') {
            _image == null;
            notifyListeners();
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
            );
          }
          if (SessionController().role == 'Mechanic') {
            _image == null;
            notifyListeners();
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
            );
          }

          // if (_image == null) {
          //   Utils.flushBarErrorMessage(
          //       'Please add an image', BuildContext, context);
          // }

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
  }

  @override
  notifyListeners();
}
