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
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class EmergencyServiceController with ChangeNotifier {
  FirebaseFirestore db = FirebaseFirestore.instance;
  // status lodaing
  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  String _VideoUrl = '';
  String get VideoUrl => _VideoUrl;
  setVideoUrl(String value) {
    _VideoUrl = value;
    notifyListeners();
  }

  // final picker = ImagePicker();
  // File? _imageFile;
  // File? get imageFile => _imageFile;
  // //pick image
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

  File? _videoFile;
  File? get videoFile => _videoFile;
  //pickVideo
  Future<void> pickVideo(BuildContext context) async {
    final pickedFile =
        await ImagePicker().pickVideo(source: ImageSource.gallery);

    if (pickedFile != null) {
      _videoFile = File(pickedFile.path);
      print(_videoFile);
      notifyListeners();
    }
  }

  // sign up func
  Future<void> emergencyService(
    BuildContext context,
    String vin,
    String currentMileage,
    String engineHours,
    String complaint,
    String additionalComplaint,
    String location,
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
      if (_videoFile != null) {
        await uploadImage(docId, File(_videoFile!.path).absolute).then((value) {
          setVideoUrl(value);
        });
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
        'image': _imageUrls,
        'video': VideoUrl,
        'status': 'pending',
        'approved': false,
        'type': 'emg',
        'assignedBy': '',
        'assignedTo': '',
        'technicianNotes': '',
        'managerNotes': '',
        'additionalComplaint': additionalComplaint,
        'location': location,
      };
      // saving user data in database
      await ScheduleServiceRepository()
          .scheduleService(docId, data)
          .then((value) {
        Get.to(AllSuccessScreen());
        _images = [];
        setLoading(false);
        notifyListeners();
      });
    } catch (e) {
      log(e.toString());
      _images = [];
      notifyListeners();
      setLoading(false);
    }
    setLoading(false);
  }

  @override
  notifyListeners();
}

Future uploadImage(postId, imagePath) async {
  firebase_storage.Reference storageRef =
      firebase_storage.FirebaseStorage.instance.ref('/posts/${postId}');

  firebase_storage.UploadTask uploadTask = storageRef.putFile(imagePath);
  await Future.value(uploadTask);
  final newUrl = await storageRef.getDownloadURL();
  return newUrl;
}
