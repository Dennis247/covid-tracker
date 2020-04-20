import 'package:flutter/material.dart';

class Contact {
  final DateTime conatctDate;
  final String deviceId;
  final String contactId;
  final double latitude;
  final double longitude;
  final double distance;
  final String referenceId;

  //userRef to make iit easy
  final String imageUrl;
  final String email;
  final String displayName;

  Contact(
      {@required this.conatctDate,
      @required this.deviceId,
      @required this.contactId,
      @required this.latitude,
      @required this.longitude,
      @required this.distance,
      @required this.referenceId,
      @required this.imageUrl,
      @required this.email,
      @required this.displayName});
}
