import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

Future<String> uploadImage(String imageName) async {
  final _firebaseStorage = FirebaseStorage.instance;

  //Select Image
  final ImagePicker _picker = ImagePicker();
  final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
  var file = File(image?.path ?? "");

  if (image != null) {
    //Upload to Firebase
    var snapshot =
        await _firebaseStorage.ref().child('images/$imageName').putFile(file);
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  } else {
    return '';
  }
}

Future<XFile?> getImage() async {
  //Select Image
  final ImagePicker _picker = ImagePicker();
  final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
  return image;
}

Future<String> sendImage(String imageName, XFile image) async {
  final _firebaseStorage = FirebaseStorage.instance;
  var file = File(image.path);

  //Upload to Firebase
  var snapshot =
      await _firebaseStorage.ref().child('images/$imageName').putFile(file);
  String downloadUrl = await snapshot.ref.getDownloadURL();
  return downloadUrl;
}
