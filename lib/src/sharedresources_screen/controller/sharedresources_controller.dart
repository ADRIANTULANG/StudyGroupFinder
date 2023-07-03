import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import '../../../services/getstorage_services.dart';
import '../model/sharedresources_files_model.dart';
import '../widget/sharedresources_alertdialog.dart';

class SharedResourcesController extends GetxController {
  RxString groupID = ''.obs;
  RxString group_name = ''.obs;

  RxString filePath = ''.obs;
  RxString fileName = ''.obs;
  RxString fileType = ''.obs;
  File? pickedFile;

  TextEditingController description = TextEditingController();

  Uint8List? uint8list;

  UploadTask? uploadTask;

  List<String> formats = [
    'png',
    'jpg',
    'svg',
    'jpeg',
    'gif',
    'docx',
    'csv',
    'pdf',
    'xls',
    'xlsx',
    'ppt',
    'pptx',
    'txt'
  ];

  RxList<FileModel> fileList = <FileModel>[].obs;

  @override
  void onInit() async {
    groupID.value = await Get.arguments['group_id'];
    group_name.value = await Get.arguments['group_name'];
    getFiles();
    super.onInit();
  }

  getFiles() async {
    List data = [];
    var groupDocumentReference = await FirebaseFirestore.instance
        .collection('groups')
        .doc(groupID.value);
    var res = await FirebaseFirestore.instance
        .collection('groupfiles')
        .where('groupid', isEqualTo: groupDocumentReference)
        .get();
    var files = res.docs;
    for (var i = 0; i < files.length; i++) {
      var userDetails = await files[i]['userid'].get();
      Map obj = {
        "id": files[i].id,
        "dateCreated": files[i]['dateCreated'].toDate().toString(),
        "fileLink": files[i]['fileLink'],
        "filedescription": files[i]['fileLink'],
        "filename": files[i]['filename'],
        "filetype": files[i]['filetype'],
        "user_name":
            userDetails.get('firstname') + " " + userDetails.get('lastname'),
        "user_image": userDetails.get('image'),
      };
      data.add(obj);
    }
    var jsonEncodedData = jsonEncode(data);
    fileList.assignAll(fileModelFromJson(jsonEncodedData));
  }

  pickFile() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: formats);
    if (result != null) {
      pickedFile = File(result.files.single.path!);
      filePath.value = result.files.single.path!;
      fileName.value = result.files.single.name;
      fileType.value = result.files.single.extension!;
      uint8list = Uint8List.fromList(File(filePath.value).readAsBytesSync());
    } else {
      // User canceled the picker
    }
  }

  uploadFile() async {
    try {
      String fileLink = '';
      var userDocumentReference = await FirebaseFirestore.instance
          .collection('users')
          .doc(Get.find<StorageServices>().storage.read('id'));
      var groupDocumentReference = await FirebaseFirestore.instance
          .collection('groups')
          .doc(groupID.value);
      if (pickedFile != null) {
        final ref = await FirebaseStorage.instance
            .ref()
            .child("files/${fileName.value}");
        uploadTask = ref.putData(uint8list!);
        final snapshot = await uploadTask!.whenComplete(() {});
        fileLink = await snapshot.ref.getDownloadURL();
      }
      await FirebaseFirestore.instance.collection('groupfiles').add({
        "filename": fileName.value,
        "filetype": fileType.value,
        "fileLink": fileLink,
        "filedescription": description.text,
        "userid": userDocumentReference,
        "groupid": groupDocumentReference,
        "dateCreated": DateTime.now()
      });
      Get.back();
      SharedResourcesAlertDialogs.showSuccessUpload();

      getFiles();
    } catch (e) {
      print("error: $e");
    }
  }

  downloadFile(
      {required String link,
      required int index,
      required String filename}) async {
    fileList[index].isDownloading.value = true;

    FileDownloader.downloadFile(
        url: link,
        name: filename,
        onProgress: (fileName, progress) {
          double percent = progress / 100;
          fileList[index].progress.value = percent;
        },
        onDownloadCompleted: (String path) {
          fileList[index].isDownloading.value = false;
        },
        onDownloadError: (String error) {
          fileList[index].isDownloading.value = false;
          print("ERROR: $error");
        });
  }
}
