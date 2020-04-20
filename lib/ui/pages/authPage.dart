import 'package:covid_tracker/provider/authProvider.dart';
import 'package:covid_tracker/utils/constants.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:covid_tracker/utils/styles.dart';
import 'homePage.dart';

class AuthPage extends StatefulWidget {
  static final routeName = "auth-page";

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.2,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Image.asset("assets/images/4.png"),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.1,
            ),
            SizedBox(
              height: 48,
              width: MediaQuery.of(context).size.width * 0.7,
              child: MaterialButton(
                onPressed: () async {
                  await Provider.of<AuthProvider>(context, listen: false)
                      .handleSignIn();
                  Navigator.of(context)
                      .pushReplacementNamed(HomePage.routeName);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      FontAwesomeIcons.google,
                      color: Colors.red,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    isLoading
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : Text(
                            "Sign In With Google",
                            style: AppStyle.mediumTextSTyleWhite,
                          )
                  ],
                ),
                color: Constants.primaryColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
