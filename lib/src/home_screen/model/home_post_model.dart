// To parse this JSON data, do
//
//     final HomePost = HomePostFromJson(jsonString);

import 'dart:convert';

List<HomePost> homePostFromJson(String str) =>
    List<HomePost>.from(json.decode(str).map((x) => HomePost.fromJson(x)));

String homePostToJson(List<HomePost> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HomePost {
  String id;
  String image;
  String post;
  String userName;
  String userImage;
  DateTime dateCreated;
  String userId;
  String groupId;
  String groupName;

  HomePost({
    required this.id,
    required this.image,
    required this.post,
    required this.userName,
    required this.userImage,
    required this.dateCreated,
    required this.userId,
    required this.groupId,
    required this.groupName,
  });

  factory HomePost.fromJson(Map<String, dynamic> json) => HomePost(
        id: json["id"],
        image: json["image"],
        post: json["post"],
        userName: json["user_name"],
        userImage: json["user_image"],
        dateCreated: DateTime.parse(json["dateCreated"]),
        userId: json["user_id"],
        groupId: json["group_id"],
        groupName: json["group_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "post": post,
        "user_name": userName,
        "user_image": userImage,
        "dateCreated": dateCreated.toIso8601String(),
        "user_id": userId,
        "group_id": groupId,
        "group_name": groupName,
      };
}
