import 'package:covid_tracker/model/contactModel.dart';
import 'package:covid_tracker/provider/authProvider.dart';
import 'package:covid_tracker/provider/contactProvider.dart';
import 'package:covid_tracker/provider/deviceProvider.dart';
import 'package:covid_tracker/ui/widgets/contactWidget.dart';
import 'package:covid_tracker/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  static final routeName = "home-page";
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    Provider.of<DeviceProvider>(context, listen: false).getDeviceUpdate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Recent Contacts"),
        ),
        body: StreamBuilder(
            stream: contactReference.onValue,
            builder: (context, AsyncSnapshot<Event> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                if (snapshot.hasError) {
                  return Center(
                    child: Text("An Error Occured Getting COntacts"),
                  );
                } else {
                  List contactList = [];
                  DataSnapshot dataSnapshot = snapshot.data.snapshot;
                  Map<dynamic, dynamic> values = dataSnapshot.value;
                  values.forEach((key, value) {
                    contactList.add(value);
                  });
                  return ListView.builder(
                      itemCount: contactList.length,
                      itemBuilder: (context, index) {
                        final Contact contact = new Contact(
                            conatctDate: DateTime.parse(
                                contactList[index]['conatctDate']),
                            deviceId: contactList[index]['deviceId'],
                            contactId: contactList[index]['contactId'],
                            latitude: contactList[index]['latitude'],
                            longitude: contactList[index]['longitude'],
                            distance: double.parse(
                                contactList[index]['distance'].toString()),
                            referenceId: contactList[index]['referenceId'],
                            imageUrl: contactList[index]['imageUrl'],
                            email: contactList[index]['email'],
                            displayName: contactList[index]['displayName']);
                        return ContactWidget(contact: contact);
                      });
                }
              }
            }));
  }
}
