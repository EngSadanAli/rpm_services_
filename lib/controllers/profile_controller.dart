import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:rpm/utils/app_colors.dart';
import 'package:rpm/controllers/services/session_manager.dart';
import 'package:rpm/utils/utils.dart';

class ProfileRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String collectionName = 'users';
  //Function for profile url update
  Future<void> updateUserProfileUrl(String userId, String profileUrl) async {
    await _firestore.collection(collectionName).doc(userId).update({
      'profileImage': profileUrl,
    });
  }

  //Function for info update
  Future<void> updateUserInfo(
      String userId, String dataBaseID, String updatedData) async {
    await _firestore.collection(collectionName).doc(userId).update({
      dataBaseID: updatedData,
    });
  }
}

class ProfileController with ChangeNotifier {
  //initialising repo class.
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
      uploadImage(context);
      notifyListeners();
    }
  }

  void uploadImage(BuildContext context) async {
    setLoading(true);
    firebase_storage.Reference storageRef = firebase_storage
        .FirebaseStorage.instance
        .ref('/profileImage/profileImage${SessionController().userId}');

    firebase_storage.UploadTask uploadTask =
        storageRef.putFile(File(image!.path).absolute);

    await Future.value(uploadTask);
    final newUrl = await storageRef.getDownloadURL();
    await _repository
        .updateUserProfileUrl(SessionController().userId.toString(), newUrl)
        .then((value) {
      SessionController().profilePic = newUrl;
      Utils.toastMessage('Profile update');
      setLoading(false);
      _image = null;
    }).onError((error, stackTrace) {
      setLoading(false);
      Utils.toastMessage(error.toString());
    });
  }

  final textController = TextEditingController();
  final nameFocusNode = FocusNode();

  //==============update user info func====================//
  Future<void> updateDialogAlert(
    BuildContext context,
    String oldValue,
    String dbFieldId,
    TextInputType textInputType,
  ) {
    textController.text = oldValue;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: AppColors.textFieldBorderColor,
            title: Center(
                child: Text(
              'Update Info',
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(color: AppColors.blackColor),
            )),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: textController,
                  focusNode: nameFocusNode,
                  keyboardType: textInputType,
                  obscureText: false,
                  decoration: InputDecoration(
                      hintText: 'Enter...', fillColor: AppColors.grayText2),
                )
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel',
                      style: Theme.of(context).textTheme.titleSmall!
                      // .copyWith(color: AppColors.redTextColor),
                      )),
              TextButton(
                  onPressed: () {
                    _repository
                        .updateUserInfo(SessionController().userId.toString(),
                            dbFieldId, textController.text.toString())
                        .then((value) {
                      if (dbFieldId == 'name') {
                        SessionController().name =
                            textController.text.toString();
                      } else if (dbFieldId == 'phone') {
                        SessionController().phone =
                            textController.text.toString();
                      }
                      textController.clear();
                    });
                    Navigator.pop(context);
                  },
                  child: Text('Ok',
                      style: Theme.of(context).textTheme.titleSmall!))
            ],
          );
        });
  }
}
