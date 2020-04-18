import 'package:covid_tracker/model/userModel.dart';
import 'package:covid_tracker/utils/constants.dart';
import 'package:device_id/device_id.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

String deviceId;

class AuthProvider with ChangeNotifier {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final contactRef = FirebaseDatabase.instance.reference().child('contacts');
  GoogleSignInAccount googleUser;
  User loggedInContact;
  bool isLoggedIn = false;
  bool hasOnboarded = false;

  Future<void> handleSignIn() async {
    try {
      await googleSignIn.signIn().then((_) async {
        await _createContact();
        await _storePreferenceData();
        isLoggedIn = true;
        notifyListeners();
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _storePreferenceData() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    final userData = json.encode({
      'id': googleUser.id,
      'email': googleUser.email,
      'photoUrl': googleUser.photoUrl,
      'displayName': googleUser.displayName,
      'deviceId': deviceId,
    });

    final onBoardedData = json.encode({
      'id': googleUser.id,
      'onBoarded': 'true',
    });

    sharedPrefs.setString(Constants.onBoard, onBoardedData);
    sharedPrefs.setString(Constants.userData, userData);

    //store obboardedPreference
  }

  Future<void> handleSignOut() async {
    try {
      await googleSignIn.signOut();
      loggedInContact = null;
      final prefs = await SharedPreferences.getInstance();
      prefs.remove(Constants.userData);
      isLoggedIn = false;
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }

  checkUserOnBoarding() async {
    final sharedPref = await SharedPreferences.getInstance();
    if (!sharedPref.containsKey(Constants.onBoard)) {
      hasOnboarded = false;
    } else {
      hasOnboarded = true;
    }

    // return true;
  }

  Future<bool> tryAutoLogin() async {
    await checkUserOnBoarding();
    final sharedPref = await SharedPreferences.getInstance();
    if (!sharedPref.containsKey(Constants.userData)) {
      return false;
    }
    final sharedData = sharedPref.getString(Constants.userData);
    final extractedUserData = json.decode(sharedData) as Map<String, Object>;
    loggedInContact = new User(
        id: extractedUserData['id'],
        email: extractedUserData['email'],
        photoUrl: extractedUserData['photoUrl'],
        displayName: extractedUserData['displayName'],
        deviceId: extractedUserData['deviceId']);

    isLoggedIn = true;
    notifyListeners();
    return true;
  }

  Future<void> _createContact() async {
    try {
      googleUser = googleSignIn.currentUser;
      GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      // FirebaseUser firebaseUser =
      //     (await auth.signInWithCredential(credential)).user;
      // if (firebaseUser != null) {
      deviceId = await DeviceId.getID;
      await contactRef
          .child(googleUser.id)
          .once()
          .then((DataSnapshot dataSnapshot) {
        if (dataSnapshot.value == null) {
          contactRef.child(googleUser.id).update({
            "id": googleUser.id,
            "email": googleUser.email,
            "photoUrl": googleUser.photoUrl,
            "displayName": googleUser.displayName,
            "deviceId": deviceId
          });
        }
      });
      // }
    } catch (e) {
      print(e.toString());
    }
  }
}
