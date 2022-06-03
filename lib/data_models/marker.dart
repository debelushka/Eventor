import 'package:flutter/cupertino.dart';

class UMarker {
  String? username;
  String? date;
  String? time;
  String? image;
  String? latitude;
  String? longitude;
  String? telegram;
  String? desc;
  bool? error = false;
  UMarker({
    required this.error,
  });
  UMarker.create(
      {required this.username,
      required this.date,
      required this.time,
      required this.image,
      required this.latitude,
      required this.longitude,
      required this.telegram,
      required this.desc});
  UMarker.fromJson(Map<String, dynamic> json)
      : username = json['username'],
        date = json['date'],
        time = json['time'],
        image = json['image'],
        latitude = json['latitude'],
        longitude = json['longitude'],
        telegram = json['telegram'],
        desc = json['desc'];

  Map<String, dynamic> toJson() => {
        'username': username,
        'date': date,
        'time': time,
        'image': image,
        'latitude': latitude,
        'longitude': longitude,
        'telegram': telegram,
        'desc': desc
      };
}
