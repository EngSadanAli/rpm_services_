import 'dart:core';
import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rpm/Views/driver_dashboard/SelectDataAndTimeScreen/AllSuccessScreen/all_success_screen.dart';
import 'package:rpm/controllers/services/session_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rpm/repository/schedule_service_repository.dart';
import 'package:uuid/uuid.dart';

class EmergencyServiceController with ChangeNotifier {
  FirebaseFirestore db = FirebaseFirestore.instance;
  // status lodaing
  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  final picker = ImagePicker();
  File? _imageFile;
  File? get imageFile => _imageFile;
  //pick image
  Future<void> pickImage(BuildContext context, ImageSource imageSource) async {
    final pickedFile =
        await picker.pickImage(source: imageSource, imageQuality: 100);

    if (pickedFile != null) {
      _imageFile = File(pickedFile.path);
      notifyListeners();
    }
  }

  // sign up func
  void emergencyService(
    BuildContext context,
    String vin,
    String currentMileage,
    String engineHours,
    String complaint,
  ) async {
    setLoading(true);
    try {
      var docId = const Uuid().v4();
      setLoading(true);
      await ScheduleServiceRepository()
          .uploadImage(docId, File(_imageFile!.path).absolute)
          .then((newUrl) {
        var data = {
          'docId': docId,
          'vin': vin,
          'currentMileage': currentMileage,
          'engineHours': engineHours,
          'complaint': complaint,
          'name': SessionController().name,
          'uid': SessionController().userId,
          'phone': SessionController().phone,
          'image': newUrl,
          'status': 'pending',
          'type': 'emg',
        };
        // saving user data in database
        ScheduleServiceRepository().scheduleService(docId, data);
      }).then((value) => Get.to(AllSuccessScreen()));
    } catch (e) {
      log(e.toString());
      setLoading(false);
    }
    setLoading(false);
  }

  @override
  notifyListeners();
}
