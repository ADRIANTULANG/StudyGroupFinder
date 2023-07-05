import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sgf/src/home_screen/controller/home_controller.dart';

import '../../../services/getstorage_services.dart';
import '../model/groupdetails_post_model.dart';
import '../model/groupdetails_request_model.dart';
import '../widget/groupdetails_alertdialogs.dart';

class GroupDetailController extends GetxController {
  RxString group_id = ''.obs;
  RxString group_name = ''.obs;
  RxString group_description = ''.obs;
  RxString group_image = ''.obs;

  final ImagePicker picker = ImagePicker();
  File? picked_image;
  RxString imagePath = ''.obs;
  RxString filename = ''.obs;
  Uint8List? uint8list;
  UploadTask? uploadTask;

  RxBool isJoined = true.obs;
  RxBool isAdmin = false.obs;

  RxInt membersCount = 0.obs;

  TextEditingController posttext = TextEditingController();

  TextEditingController purpose = TextEditingController();

  RxList<GroupPost> postList = <GroupPost>[].obs;
  RxList<RequestModel> requestList = <RequestModel>[].obs;

  RxBool isDeleting = false.obs;
  RxBool isPosting = false.obs;
  RxBool isSubmitting = false.obs;

  @override
  void onInit() async {
    super.onInit();
    group_id.value = await Get.arguments['group_id'];
    group_name.value = await Get.arguments['group_name'];
    group_description.value = await Get.arguments['group_description'];
    group_image.value = await Get.arguments['group_image'];
    getPost();
    checkIfAlreadyJoinedOrNot();
    countMembers();
    getRequest();
  }

  countMembers() async {
    var groupDocumentReference = await FirebaseFirestore.instance
        .collection('groups')
        .doc(group_id.value);
    var count = await FirebaseFirestore.instance
        .collection('members')
        .where('group_id', isEqualTo: groupDocumentReference)
        .get();
    membersCount.value = count.docs.length;
  }

  checkIfAlreadyJoinedOrNot() async {
    var userDocumentReference = await FirebaseFirestore.instance
        .collection('users')
        .doc(Get.find<StorageServices>().storage.read('id'));
    var groupDocumentReference = await FirebaseFirestore.instance
        .collection('groups')
        .doc(group_id.value);
    var res = await FirebaseFirestore.instance
        .collection('members')
        .where('group_id', isEqualTo: groupDocumentReference)
        .where('member_id', isEqualTo: userDocumentReference)
        .limit(1)
        .get();
    var memberDetail = res.docs;
    if (memberDetail.length > 0) {
      isJoined.value = true;
      if (memberDetail[0]['role'] == 'Admin') {
        isAdmin.value = true;
      }
    } else {
      isJoined.value = false;
      isAdmin.value = false;
    }
  }

  getPost() async {
    List data = [];
    var res = await FirebaseFirestore.instance
        .collection('post')
        .where('group_id', isEqualTo: group_id.value)
        .get();
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
    postList.assignAll(await groupPostFromJson(jsonEncodedData));
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

  createPost() async {
    try {
      isPosting.value = true;
      var urlDownload = '';
      if (filename.value != '') {
        final ref = await FirebaseStorage.instance
            .ref()
            .child("files/${filename.value}");
        uploadTask = ref.putData(uint8list!);
        final snapshot = await uploadTask!.whenComplete(() {});
        urlDownload = await snapshot.ref.getDownloadURL();
      }
      // var groupDocumentReference = await FirebaseFirestore.instance
      //     .collection('groups')
      //     .doc(group_id.value);
      var userDetails = await FirebaseFirestore.instance
          .collection('users')
          .doc(Get.find<StorageServices>().storage.read('id'))
          .get();
      await FirebaseFirestore.instance.collection('post').add({
        "group_id": group_id.value,
        "group_name": group_name.value,
        "image": urlDownload,
        "dateCreated": DateTime.now(),
        "post": posttext.text,
        "user": Get.find<StorageServices>().storage.read('id'),
        "user_name": Get.find<StorageServices>().storage.read('firstname') +
            " " +
            Get.find<StorageServices>().storage.read('lastname'),
        "user_image": userDetails.get('image')
      });
      Get.back();
      getPost();
      Get.find<HomeController>().getPost();
      isPosting.value = false;
    } catch (e) {
      print("error: $e");
      isPosting.value = false;
    }
  }

  getRequest() async {
    List data = [];
    var groupDocumentReference = await FirebaseFirestore.instance
        .collection('groups')
        .doc(group_id.value);
    var res = await FirebaseFirestore.instance
        .collection('request')
        .where('group_id', isEqualTo: groupDocumentReference)
        .where('status', isEqualTo: 'Pending')
        .get();

    var request = res.docs;
    for (var i = 0; i < request.length; i++) {
      Map obj = {
        "id": request[i].id,
        "user_name": request[i]['user_name'],
        "user_image": request[i]['user_image'],
        "purpose": request[i]['purpose'],
        "groupid": request[i]['group_id'].id,
        "userid": request[i]['user_id'].id,
        "dateCreate": request[i]['dateCreate'].toDate().toString(),
      };
      data.add(obj);
    }

    var jsonEncodeData = jsonEncode(data);
    requestList.assignAll(await requestModelFromJson(jsonEncodeData));
  }

  createRequest() async {
    try {
      var groupDocumentReference = await FirebaseFirestore.instance
          .collection('groups')
          .doc(group_id.value);
      var userDocumentReference = await FirebaseFirestore.instance
          .collection('users')
          .doc(Get.find<StorageServices>().storage.read('id'));
      var userDetails = await userDocumentReference.get();
      await FirebaseFirestore.instance.collection('request').add({
        "group_id": groupDocumentReference,
        "user_id": userDocumentReference,
        "user_name": Get.find<StorageServices>().storage.read('firstname') +
            " " +
            Get.find<StorageServices>().storage.read('lastname'),
        "user_image": userDetails.get('image'),
        "purpose": purpose.text,
        "dateCreate": DateTime.now(),
        "status": "Pending"
      });
      Get.back();
      GroupDetailsAlertDialog.showSuccessRequest();
    } on Exception catch (e) {
      print(e);
    }
  }

  acceptOrDeclineRequest(
      {required bool isApproved, required RequestModel requestDetails}) async {
    try {
      if (isApproved == true) {
        var groupDocumentReference = await FirebaseFirestore.instance
            .collection('groups')
            .doc(requestDetails.groupid);
        var userDocumentReference = await FirebaseFirestore.instance
            .collection('users')
            .doc(requestDetails.userid);
        var groupDetails = await groupDocumentReference.get();
        var userDetails = await userDocumentReference.get();
        await FirebaseFirestore.instance.collection('members').add({
          "member_id": userDocumentReference,
          "group_id": groupDocumentReference,
          "group_name": groupDetails.get('name'),
          "member_name":
              userDetails.get('firstname') + " " + userDetails.get('lastname'),
          "role": 'Member',
        });
        await FirebaseFirestore.instance
            .collection('request')
            .doc(requestDetails.id)
            .delete();
      } else {
        await FirebaseFirestore.instance
            .collection('request')
            .doc(requestDetails.id)
            .delete();
      }
      getRequest();
    } catch (e) {
      print(e);
    }
  }

  deleteGroup() async {
    try {
      isDeleting.value = true;
      var groupDocumentReference = await FirebaseFirestore.instance
          .collection('groups')
          .doc(group_id.value);
      await FirebaseFirestore.instance
          .collection('groups')
          .doc(group_id.value)
          .delete();

      // DELETE MEMBERS FOR THIS GROUP
      final membersBatchRef = await FirebaseFirestore.instance
          .collection('members')
          .where("group_id", isEqualTo: groupDocumentReference)
          .get();
      WriteBatch memberbatch = FirebaseFirestore.instance.batch();
      for (final member in membersBatchRef.docs) {
        var memberDocumentReference = await FirebaseFirestore.instance
            .collection('members')
            .doc(member.id);
        memberbatch.delete(memberDocumentReference);
      }
      await memberbatch.commit();

      // DELETE FILES FOR THIS GROUP
      final groupFilesBatchRef = await FirebaseFirestore.instance
          .collection('groupfiles')
          .where("groupid", isEqualTo: groupDocumentReference)
          .get();
      WriteBatch groupfilesbatch = FirebaseFirestore.instance.batch();
      for (final files in groupFilesBatchRef.docs) {
        var groupFilesDocumentReference = await FirebaseFirestore.instance
            .collection('groupfiles')
            .doc(files.id);
        groupfilesbatch.delete(groupFilesDocumentReference);
      }
      await groupfilesbatch.commit();

      // DELETE POST FOR THIS GROUP
      final postBatchRef = await FirebaseFirestore.instance
          .collection('post')
          .where("group_id", isEqualTo: group_id.value)
          .get();
      WriteBatch postfilesbatch = FirebaseFirestore.instance.batch();
      for (final post in postBatchRef.docs) {
        var postDocumentReference =
            await FirebaseFirestore.instance.collection('post').doc(post.id);
        postfilesbatch.delete(postDocumentReference);
      }
      await postfilesbatch.commit();
      Get.back();
      Get.back();
      Get.find<HomeController>().getMyGroups();
      Get.find<HomeController>().getGroups();
      Get.find<HomeController>().getPost();
      isDeleting.value = false;
    } catch (e) {
      isDeleting.value = false;
    }
  }
}
