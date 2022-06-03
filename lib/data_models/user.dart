import 'package:flutter/cupertino.dart';

class User {
  String username;
  String? nphone;
  String? pass;
  String? description;
  String? image;
  User({
    required this.username,
  });
  User.fromJson(Map<String, dynamic> json)
      : username = json['username'],
        nphone = json['nphone'],
        pass = json['pass'],
        description = json['description'],
        image = json['image'];

  Map<String, dynamic> toJson() => {
        'username': username,
        'nphone': nphone,
        'pass': pass,
        'description': description,
        'image': image
      };
}
