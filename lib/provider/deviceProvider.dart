import 'package:background_location/background_location.dart';
import 'package:covid_tracker/model/contactModel.dart';
import 'package:covid_tracker/model/deviceModel.dart';
import 'package:covid_tracker/provider/authProvider.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:great_circle_distance2/great_circle_distance2.dart';

import 'contactProvider.dart';

class DeviceProvider with ChangeNotifier {
  final deviceReference =
      FirebaseDatabase.instance.reference().child('devices');
  List<Device> _alldevices = [];
  List<Device> get allDevices {
    return _alldevices;
  }

  Device currentUserDevice;

  getAllDevices() {
    try {
      _alldevices.clear();
      deviceReference.once().then((DataSnapshot dataSnapshot) {
        Map<dynamic, dynamic> deviceList = dataSnapshot.value;
        deviceList.forEach((key, value) {
          final device = Device(
            deviceId: value['deviceId'],
            userId: value['userId'],
            latitude: value['latitude'],
            longitude: value['longitude'],
            locationTime: DateTime.parse(value['locationTime'].toString()),
          );
          _alldevices.add(device);
        });
        _processDeviceDistance();
      });
    } catch (e) {}
  }

  Future<void> getDeviceUpdate() async {
    BackgroundLocation.getPermissions(
      onGranted: () {
        //get current device location
        BackgroundLocation.startLocationService();
        BackgroundLocation().getCurrentLocation().then((location) {
          _updateCurrentDeviceInfo(location.latitude, location.longitude);
          _updateDeviceLocation(currentUserDevice);
        });
        //get device location as it changes
        BackgroundLocation.getLocationUpdates((location) {
          _updateCurrentDeviceInfo(location.latitude, location.longitude);
          _updateDeviceLocation(currentUserDevice);

          getAllDevices();
        });
      },
      onDenied: () {
        // Show a message asking the user to reconsider or do something else
        //throw execption that location has been denied
      },
    );
  }

  void _processDeviceDistance() {
    if (_alldevices.length > 0) {
      _alldevices.forEach((contactDevice) {
        if (currentUserDevice.deviceId != contactDevice.deviceId) {
          DateTime timeStamp = DateTime.now();
          //check if device has been in same location for the last 1 hour
          if (timeStamp.difference(contactDevice.locationTime) <=
              Duration(hours: 1)) {
            //calculate distance between device
            final contactDistance = _caculateDeviceDistanceInMeters(
                currentUserDevice.latitude,
                currentUserDevice.longitude,
                contactDevice.latitude,
                contactDevice.longitude);
            if (contactDistance <= 6) {
              //create contact if device contact is less than or equal to 6 meters
              Contact contact = new Contact(
                  conatctDate: DateTime.now(),
                  deviceId: contactDevice.deviceId,
                  contactId: contactDevice.userId,
                  latitude: contactDevice.latitude,
                  longitude: contactDevice.longitude,
                  distance: contactDistance,
                  referenceId: currentUserDevice.userId,
                  displayName: loggedInUser.displayName,
                  email: loggedInUser.email,
                  imageUrl: loggedInUser.photoUrl);
              _updateContact(contact);
            }
          }
        }
      });
    }
  }

  double _caculateDeviceDistanceInMeters(
      double lat1, double long1, double lat2, double long2) {
    var gcd = new GreatCircleDistance.fromDegrees(
        latitude1: lat1, longitude1: long1, latitude2: lat2, longitude2: long2);
    final result = gcd.vincentyDistance() / 1000;
    return result;
  }

  _updateDeviceLocation(Device device) {
    deviceReference.child(device.deviceId).set({
      'latitude': device.latitude,
      'longitude': device.longitude,
      'deviceId': device.deviceId,
      'userId': device.userId,
      'locationTime': device.locationTime
    });
  }

  _updateContact(Contact contact) {
    contactReference.child(contact.contactId).set({
      'conatctDate': contact.conatctDate.toIso8601String(),
      'distance': contact.distance,
      'deviceId': contact.deviceId,
      'latitude': contact.latitude,
      'longitude': contact.longitude,
      'contactId': contact.contactId,
      'referenceId': contact.referenceId,
      'displayName': contact.displayName,
      'imageUrl': contact.imageUrl,
      'email': contact.email
    });
  }

  _updateCurrentDeviceInfo(double latitude, double longitude) {
    currentUserDevice = Device(
        deviceId: loggedInUser.deviceId,
        userId: loggedInUser.id,
        latitude: latitude,
        longitude: longitude,
        locationTime: DateTime.now());
  }
}
