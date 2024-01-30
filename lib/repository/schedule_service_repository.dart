import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class ScheduleServiceRepository {
  final CollectionReference _scheduleServiceCollection =
      FirebaseFirestore.instance.collection('service');
  // func for createPost
  Future<void> scheduleService(String docId, data) async {
    await _scheduleServiceCollection.doc(docId).set(data);
  }

  // func for uploadImage
  Future uploadImage(docId, imagePath) async {
    firebase_storage.Reference storageRef =
        firebase_storage.FirebaseStorage.instance.ref('/service/${docId}');

    firebase_storage.UploadTask uploadTask = storageRef.putFile(imagePath);
    await Future.value(uploadTask);
    final newUrl = await storageRef.getDownloadURL();
    return newUrl;
  }
}
