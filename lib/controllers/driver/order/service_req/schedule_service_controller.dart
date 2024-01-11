import 'dart:core';
import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rpm/Views/driver_dashboard/SelectDataAndTimeScreen/AllSuccessScreen/all_success_screen.dart';
import 'package:rpm/controllers/services/session_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rpm/repository/schedule_service_repository.dart';
import 'package:uuid/uuid.dart';

class ScheduleServiceController with ChangeNotifier {
  FirebaseFirestore db = FirebaseFirestore.instance;
  // status lodaing
  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  // final picker = ImagePicker();
  // File? _imageFile;
  // File? get imageFile => _imageFile;
  //pick image
  // Future<void> pickImage(BuildContext context, ImageSource imageSource) async {
  //   final pickedFile =
  //       await picker.pickImage(source: imageSource, imageQuality: 100);

  //   if (pickedFile != null) {
  //     _imageFile = File(pickedFile.path);
  //     notifyListeners();
  //   }
  // }
  List<File> _images = [];
  List<File> get images => _images;
  List<String> _imageUrls = [];
  Future<void> pickImage(BuildContext context) async {
    final images = await ImagePicker().pickMultiImage();
    if (images != null) {
      // imagefiles = pickedfiles;
      _images = images.map((image) => File(image.path)).toList();

      notifyListeners();
    }
  }

  // sign up func
  Future<void> scheduleService(
    BuildContext context,
    String vin,
    String currentMileage,
    String engineHours,
    String complaint,
    String selectedDate,
    String selectedTime,
    String Additionalcomplaint,
  ) async {
    setLoading(true);
    try {
      var docId = const Uuid().v4();
      setLoading(true);
      // await ScheduleServiceRepository()
      //     .uploadImage(docId, File(_imageFile!.path).absolute)
      //     .then((newUrl) {
      final _storage = FirebaseStorage.instance;
      for (var image in _images) {
        // Create a reference to the Firebase Storage location
        final storageRef =
            _storage.ref().child('images/${DateTime.now().toString()}');

        // Upload the file to Firebase Storage
        final uploadTask = storageRef.putFile(image);
        await uploadTask;

        // Get the download URL for the image
        final imageUrl = await storageRef.getDownloadURL();
        _imageUrls.add(imageUrl);
      }

      // Store the download URLs in Firestore
      var data = {
        'docId': docId,
        'vin': vin,
        'currentMileage': currentMileage,
        'engineHours': engineHours,
        'complaint': complaint,
        'name': SessionController().name,
        'uid': SessionController().userId,
        'phone': SessionController().phone,
        'selectedDate': selectedDate,
        'selectedTime': selectedTime,
        'image': _imageUrls,
        'status': 'pending',
        'type': 'normal',
        'assignedBy': '',
        'assignedTo': '',
        'approved': false,
        'technicianNotes': '',
        'managerNotes': '',
        'additionalComplaint': Additionalcomplaint,
      };
      // saving user data in database
      await ScheduleServiceRepository()
          .scheduleService(docId, data)
          .then((value) {
        Get.to(AllSuccessScreen());
        _images = [];
        notifyListeners();
      });
    } catch (e) {
      log(e.toString());
      setLoading(false);
    }
    setLoading(false);
  }

  @override
  notifyListeners();
}
