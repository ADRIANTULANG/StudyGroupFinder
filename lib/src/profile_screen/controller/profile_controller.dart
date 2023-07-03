import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sgf/services/getstorage_services.dart';

import '../widget/profile_alertdialogs.dart';

class ProfileController extends GetxController {
  TextEditingController firstname = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController contact = TextEditingController();
  TextEditingController address = TextEditingController();

  final ImagePicker picker = ImagePicker();
  File? picked_image;
  RxString imagePath = ''.obs;
  RxString filename = ''.obs;
  Uint8List? uint8list;

  UploadTask? uploadTask;
  RxString imageLink =
      'https://firebasestorage.googleapis.com/v0/b/studygroupfinder-1c13d.appspot.com/o/files%2Fvectorprofile.png?alt=media&token=c53b7efa-6553-49aa-a988-aaee9062527b'
          .obs;

  @override
  void onInit() {
    getUserDetails();
    super.onInit();
  }

  getUserDetails() async {
    try {
      var userDetails = await FirebaseFirestore.instance
          .collection('users')
          .doc(Get.find<StorageServices>().storage.read('id'))
          .get();

      firstname.text = userDetails.get('firstname');
      lastname.text = userDetails.get('lastname');
      username.text = userDetails.get('username');
      password.text = userDetails.get('password');
      contact.text = userDetails.get('contact');
      address.text = userDetails.get('address');
      if (userDetails.get('image') != "") {
        imageLink.value = userDetails.get('image');
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  getImage() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      picked_image = File(image.path);
      imagePath.value = picked_image!.path;
      filename.value = picked_image!.path.split('/').last;
      uint8list = Uint8List.fromList(File(imagePath.value).readAsBytesSync());
    }
  }

  updateAccount() async {
    try {
      if (picked_image != null) {
        final ref = await FirebaseStorage.instance
            .ref()
            .child("files/${filename.value}");
        uploadTask = ref.putData(uint8list!);
        final snapshot = await uploadTask!.whenComplete(() {});
        imageLink.value = await snapshot.ref.getDownloadURL();
      }

      await FirebaseFirestore.instance
          .collection('users')
          .doc(Get.find<StorageServices>().storage.read('id'))
          .update({
        "firstname": firstname.text,
        "lastname": lastname.text,
        "username": username.text,
        "password": password.text,
        "address": address.text,
        "contact": contact.text,
        "image": imageLink.value,
      });
      var postBatchRef = await FirebaseFirestore.instance
          .collection('post')
          .where('user',
              isEqualTo: Get.find<StorageServices>().storage.read('id'))
          .get();
      WriteBatch batch = FirebaseFirestore.instance.batch();
      for (final address in postBatchRef.docs) {
        batch.update(address.reference, {
          'user_image': imageLink.value,
          'user_name': firstname.text + " " + lastname.text
        });
      }
      await batch.commit();
      ProfileAlertDialogs.showSuccessUpdate();
    } catch (e) {}
  }
}
