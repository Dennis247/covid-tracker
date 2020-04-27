import 'package:covid_tracker/model/contactModel.dart';
import 'package:covid_tracker/provider/authProvider.dart';
import 'package:covid_tracker/provider/contactProvider.dart';
import 'package:covid_tracker/provider/deviceProvider.dart';
import 'package:covid_tracker/ui/pages/authPage.dart';
import 'package:covid_tracker/ui/widgets/contactWidget.dart';
import 'package:covid_tracker/utils/constants.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:covid_tracker/utils/styles.dart';

class HomePage extends StatefulWidget {
  static final routeName = "home-page";
  bool _isLoading = false;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    Provider.of<DeviceProvider>(context, listen: false).getDeviceUpdate();
    Provider.of<ContactProvider>(context, listen: false)
        .clearIsolatedContacts();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
          child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Recent Contacts",
            style: AppStyle.headerTextStyle,
          ),
          centerTitle: true,
        ),
        body: StreamBuilder(
            stream: contactReference
                .orderByChild('referenceId')
                .equalTo(loggedInUser.id)
                .onValue,
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
                  if (values == null) {
                    return Center(
                      child: Text(
                        "You Currently have no contact",
                        style: AppStyle.mediumTextSTyle,
                      ),
                    );
                  } else {
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
              }
            }),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Provider.of<AuthProvider>(context, listen: false).handleSignOut();
            Navigator.of(context).pushReplacementNamed(AuthPage.routeName);
          },
          child: Icon(FontAwesomeIcons.lock),
          backgroundColor: Constants.primaryColor,
        ),
      ),
    );
  }
}
