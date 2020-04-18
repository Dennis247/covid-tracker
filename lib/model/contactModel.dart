import 'package:flutter/material.dart';

class Contact {
  final String id;
  final DateTime conatctDate;
  final String deviceId;
  final String userId;
  final double latitude;
  final double longitude;
  final double distance;

  Contact(
      {@required this.id,
      @required this.conatctDate,
      @required this.deviceId,
      @required this.userId,
      @required this.latitude,
      @required this.longitude,
      @required this.distance});
}
