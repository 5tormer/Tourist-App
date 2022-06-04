import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class FirebaseStorageService {
  var firebaseStorageInstance = FirebaseStorage.instance.ref();

  Future<String?> getProfileImage(String email) async {
    final storageRef = firebaseStorageInstance.child('files/$email/avatar.png');
    try {
      return await storageRef.getDownloadURL();
    } catch (e) {
      return null;
    }
  }

  Future<void> setProfileImage(String email) async {
    final storageRef = firebaseStorageInstance.child('files/$email/avatar.png');
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    var _imagePath = image!.path;
    storageRef.putFile(File(_imagePath));
  }
}
