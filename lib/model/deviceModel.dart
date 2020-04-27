import 'package:flutter/material.dart';

class Device {
  final String deviceId;
  final String userId;
  final double latitude;
  final double longitude;
  final DateTime locationTime;

  //userRef to make iit easy
  final String imageUrl;
  final String email;
  final String displayName;

  Device({
    @required this.deviceId,
    @required this.userId,
    @required this.latitude,
    @required this.longitude,
    @required this.locationTime,
    @required this.imageUrl,
    @required this.email,
    @required this.displayName,
  });

  static List<Device> devicetListFromJson(List collection) {
    List<Device> deviceList =
        collection.map((json) => Device.fromJson(json)).toList();
    return deviceList;
  }

  Device.fromJson(Map<String, dynamic> json)
      : deviceId = json['deviceId'],
        latitude = json['latitude'],
        longitude = json['longitude'],
        locationTime = json['locationTime'],
        email = json['email'],
        displayName = json['displayName'],
        imageUrl = json['imageUrl'],
        userId = json['userId'];
}
