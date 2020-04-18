import 'package:flutter/material.dart';

class User {
  final String id;
  final String email;
  final String photoUrl;
  final String displayName;
  final String deviceId;

  User({
    @required this.id,
    @required this.email,
    @required this.photoUrl,
    @required this.displayName,
    @required this.deviceId,
  });

  static List<User> contactListFromJson(List collection) {
    List<User> contactList =
        collection.map((json) => User.fromJson(json)).toList();
    return contactList;
  }

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        email = json['email'],
        photoUrl = json['photoUrl'],
        deviceId = json['deviceId'],
        displayName = json['displayName'];

  Map<String, dynamic> toMapp() {
    return {
      id: this.id,
      email: this.email,
      photoUrl: this.photoUrl,
      displayName: this.displayName,
      deviceId: this.deviceId
    };
  }
}
