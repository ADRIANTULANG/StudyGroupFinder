// To parse this JSON data, do
//
//     final requestModel = requestModelFromJson(jsonString);

import 'dart:convert';

List<RequestModel> requestModelFromJson(String str) => List<RequestModel>.from(
    json.decode(str).map((x) => RequestModel.fromJson(x)));

String requestModelToJson(List<RequestModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RequestModel {
  String id;
  String userName;
  String userImage;
  String purpose;
  String userid;
  String groupid;
  DateTime dateCreate;

  RequestModel({
    required this.id,
    required this.userName,
    required this.userImage,
    required this.purpose,
    required this.userid,
    required this.groupid,
    required this.dateCreate,
  });

  factory RequestModel.fromJson(Map<String, dynamic> json) => RequestModel(
        id: json["id"],
        userName: json["user_name"],
        userImage: json["user_image"],
        groupid: json["groupid"],
        userid: json["userid"],
        purpose: json["purpose"],
        dateCreate: DateTime.parse(json["dateCreate"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_name": userName,
        "user_image": userImage,
        "groupid": groupid,
        "userid": userid,
        "purpose": purpose,
        "dateCreate": dateCreate.toIso8601String(),
      };
}
