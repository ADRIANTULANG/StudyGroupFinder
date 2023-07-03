// To parse this JSON data, do
//
//     final fileModel = fileModelFromJson(jsonString);

import 'dart:convert';

import 'package:get/get.dart';

List<FileModel> fileModelFromJson(String str) =>
    List<FileModel>.from(json.decode(str).map((x) => FileModel.fromJson(x)));

String fileModelToJson(List<FileModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FileModel {
  String id;
  DateTime dateCreated;
  String fileLink;
  String filedescription;
  String filename;
  String filetype;
  String userName;
  String userImage;
  RxBool isDownloading;
  RxDouble progress;
  FileModel({
    required this.id,
    required this.dateCreated,
    required this.fileLink,
    required this.filedescription,
    required this.filename,
    required this.filetype,
    required this.userName,
    required this.userImage,
    required this.isDownloading,
    required this.progress,
  });

  factory FileModel.fromJson(Map<String, dynamic> json) => FileModel(
        id: json["id"],
        dateCreated: DateTime.parse(json["dateCreated"]),
        fileLink: json["fileLink"],
        isDownloading: false.obs,
        filedescription: json["filedescription"],
        filename: json["filename"],
        filetype: json["filetype"],
        userName: json["user_name"],
        userImage: json["user_image"],
        progress: 0.0.obs,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "dateCreated": dateCreated.toIso8601String(),
        "fileLink": fileLink,
        "filedescription": filedescription,
        "filename": filename,
        "filetype": filetype,
        "user_name": userName,
        "user_image": userImage,
        "isDownloading": isDownloading,
        "progress": progress,
      };
}
