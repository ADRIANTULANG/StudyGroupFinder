import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sgf/src/home_screen/model/home_post_model.dart';
import 'package:sgf/src/home_screen/widget/homescreen_mygroups.dart';

import '../../../services/getstorage_services.dart';
import '../model/home_groups_model.dart';
import '../widget/homescreen_alertdialogs.dart';
import '../widget/homescreen_groups.dart';

class HomeController extends GetxController {
  Timer? debounce;
  RxInt pageindex = 0.obs;
  final ImagePicker picker = ImagePicker();
  File? picked_image;
  RxString imagePath = ''.obs;
  RxString filename = ''.obs;
  Uint8List? uint8list;
  UploadTask? uploadTask;

  TextEditingController groupname = TextEditingController();
  TextEditingController groupdescription = TextEditingController();

  RxList<Groups> groupsList = <Groups>[].obs;
  RxList<Groups> mygroupsList = <Groups>[].obs;

  RxList<HomePost> postList = <HomePost>[].obs;

  RxBool isCreatingGroup = false.obs;
  RxBool isDeleting = false.obs;

  @override
  void onInit() {
    super.onInit();
    getGroups();
    getPost();
    getMyGroups();
  }

  List<Widget> screens = [
    GroupsScreenView(),
    MyGroupsScreenView(),
  ];

  getMyGroups() async {
    List data = [];

    var userDocumentReference = await FirebaseFirestore.instance
        .collection('users')
        .doc(Get.find<StorageServices>().storage.read('id'));
    var res = await FirebaseFirestore.instance
        .collection('members')
        .where('member_id', isEqualTo: userDocumentReference)
        .get();
    var resdata = res.docs;
    for (var i = 0; i < resdata.length; i++) {
      var group = await resdata[i]['group_id'].get();
      Map obj = {
        "id": group.id,
        "name": group.get('name'),
        "description": group.get('description'),
        "dateCreated": group.get('dateCreated').toDate().toString(),
        "image": group.get('image'),
      };
      data.add(obj);
    }
    var jsonEncodedData = jsonEncode(data);
    mygroupsList.assignAll(await groupsFromJson(jsonEncodedData));
    mygroupsList.sort((b, a) => a.dateCreated.compareTo(b.dateCreated));
  }

  getGroups() async {
    List data = [];
    var res = await FirebaseFirestore.instance.collection('groups').get();
    var groups = res.docs;
    for (var i = 0; i < groups.length; i++) {
      Map obj = {
        "id": groups[i].id,
        "name": groups[i]['name'],
        "description": groups[i]['description'],
        "dateCreated": groups[i]['dateCreated'].toDate().toString(),
        "image": groups[i]['image'],
      };
      data.add(obj);
    }
    var jsonEncodedData = jsonEncode(data);
    groupsList.assignAll(await groupsFromJson(jsonEncodedData));
    groupsList.sort((b, a) => a.dateCreated.compareTo(b.dateCreated));
  }

  getPost() async {
    List data = [];
    var res = await FirebaseFirestore.instance.collection('post').get();
    var post = res.docs;
    for (var i = 0; i < post.length; i++) {
      Map obj = {
        "id": post[i].id,
        "image": post[i]['image'],
        "post": post[i]['post'],
        "user_name": post[i]['user_name'],
        "user_image": post[i]['user_image'],
        "dateCreated": post[i]['dateCreated'].toDate().toString(),
        "user_id": post[i]['user'],
        "group_id": post[i]['group_id'],
        "group_name": post[i]['group_name'],
      };
      data.add(obj);
    }
    var jsonEncodedData = jsonEncode(data);
    postList.assignAll(await homePostFromJson(jsonEncodedData));
    postList.sort((b, a) => a.dateCreated.compareTo(b.dateCreated));
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

  createGroup() async {
    try {
      isCreatingGroup.value = true;
      final ref =
          await FirebaseStorage.instance.ref().child("files/${filename.value}");
      uploadTask = ref.putData(uint8list!);
      final snapshot = await uploadTask!.whenComplete(() {});
      final urlDownload = await snapshot.ref.getDownloadURL();
      var group = await FirebaseFirestore.instance.collection('groups').add({
        "name": groupname.text.capitalizeFirst.toString(),
        "description": groupdescription.text,
        "image": urlDownload,
        "dateCreated": DateTime.now()
      });
      var groupDocumentReference =
          await FirebaseFirestore.instance.collection('groups').doc(group.id);
      var userDocumentReference = await FirebaseFirestore.instance
          .collection('users')
          .doc(Get.find<StorageServices>().storage.read('id'));
      await FirebaseFirestore.instance.collection('members').add({
        "member_id": userDocumentReference,
        "group_id": groupDocumentReference,
        "group_name": groupname.text.capitalizeFirst.toString(),
        "member_name": Get.find<StorageServices>().storage.read('firstname') +
            " " +
            Get.find<StorageServices>().storage.read('lastname'),
        "role": 'Admin',
      });
      Get.back();
      getGroups();
      isCreatingGroup.value = false;
      HomescreenAlertDialog.showSuccessCreateGroup();
    } catch (e) {
      isCreatingGroup.value = false;

      print("error: $e");
    }
  }

  deletePost({required String documentID}) async {
    isDeleting.value = true;
    try {
      await FirebaseFirestore.instance
          .collection('post')
          .doc(documentID)
          .delete();
      getPost();
    } catch (e) {}
    Get.back();
    isDeleting.value = false;
  }
}
