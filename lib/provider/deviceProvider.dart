import 'package:background_location/background_location.dart';
import 'package:covid_tracker/model/deviceModel.dart';
import 'package:covid_tracker/provider/authProvider.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:location_permissions/location_permissions.dart';

class DeviceProvider with ChangeNotifier {
  final databaseReference =
      FirebaseDatabase.instance.reference().child('devices');
  List<Device> _alldevices;
  List<Device> get allDevices {
    return _alldevices;
  }

  Future<void> getAllDevices() async {
    databaseReference.once().then((DataSnapshot dataSnapshot) {
      Map<dynamic, dynamic> deviceList = dataSnapshot.value;
    });
  }

  Future<void> getDeviceUpdate() async {
    BackgroundLocation.getPermissions(
      onGranted: () {
        //get current device location
        BackgroundLocation.startLocationService();
        BackgroundLocation().getCurrentLocation().then((location) {
          print("This is current Location" + location.longitude.toString());
        });
        //get device location as it changes
        BackgroundLocation.getLocationUpdates((location) {
          updateDeviceLocation(deviceId, location.latitude, location.latitude);
          print('${location.latitude}');
          //check from the list of device location if there is any with the device less than 6 meters or more
        });
      },
      onDenied: () {
        // Show a message asking the user to reconsider or do something else
        //throw execption that location has been denied
      },
    );
  }

  updateDeviceLocation(String deviceId, double latitude, double longitude) {
    databaseReference.child(deviceId).set({
      'latitude': latitude,
      'longitude': longitude,
    });
  }
}
