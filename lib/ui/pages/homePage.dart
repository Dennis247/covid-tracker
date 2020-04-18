import 'package:covid_tracker/provider/authProvider.dart';
import 'package:covid_tracker/provider/deviceProvider.dart';
import 'package:covid_tracker/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
        title: Text("Home Page"),
      ),
      body: Center(
        child: MaterialButton(
          color: Constants.primaryColor,
          onPressed: () async {
            await Provider.of<AuthProvider>(context, listen: false)
                .handleSignOut();
            Navigator.of(context).pushNamed("/");
          },
          child: Text("Sign Out"),
        ),
      ),
    );
  }
}
