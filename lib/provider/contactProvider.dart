import 'package:covid_tracker/model/contactModel.dart';
import 'package:covid_tracker/provider/authProvider.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

final contactReference =
    FirebaseDatabase.instance.reference().child('contacts');

class ContactProvider with ChangeNotifier {
  List<Contact> _contacts = [];
  List<Contact> get contacts {
    return _contacts;
  }

  getContacts() {
    try {
      contactReference
          .orderByChild("conatctDate")
          .equalTo(loggedInUser.id)
          .once()
          .then((dataSnapshot) {
        Map<dynamic, dynamic> contactList = dataSnapshot.value;
        contactList.forEach((key, value) {
          final contact = new Contact(
              conatctDate: value['conatctDate'],
              deviceId: value['deviceId'],
              contactId: value['contactId'],
              latitude: value['latitude'],
              longitude: value['longitude'],
              distance: value['distance'],
              referenceId: value['referenceId'],
              displayName: value['displayName'],
              email: value['email'],
              imageUrl: value['imageUrl']);
          _contacts.add(contact);
        });
      });
    } catch (e) {
      print(e.toString());
    }
  }
}
