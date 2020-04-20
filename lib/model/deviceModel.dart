import 'package:flutter/material.dart';

class Device {
  final String deviceId;
  final String userId;
  final double latitude;
  final double longitude;
  final DateTime locationTime;

  Device({
    @required this.deviceId,
    @required this.userId,
    @required this.latitude,
    @required this.longitude,
    @required this.locationTime,
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
        userId = json['userId'];
}
