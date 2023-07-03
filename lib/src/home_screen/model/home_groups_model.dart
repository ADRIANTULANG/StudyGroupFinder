// To parse this JSON data, do
//
//     final groups = groupsFromJson(jsonString);

import 'dart:convert';

List<Groups> groupsFromJson(String str) =>
    List<Groups>.from(json.decode(str).map((x) => Groups.fromJson(x)));

String groupsToJson(List<Groups> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Groups {
  String id;
  String name;
  String description;
  String image;

  DateTime dateCreated;

  Groups({
    required this.id,
    required this.name,
    required this.description,
    required this.dateCreated,
    required this.image,
  });

  factory Groups.fromJson(Map<String, dynamic> json) => Groups(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        image: json["image"],
        dateCreated: DateTime.parse(json["dateCreated"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "description": description,
        "dateCreated": dateCreated.toIso8601String(),
      };
}
