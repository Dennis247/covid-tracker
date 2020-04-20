import 'package:covid_tracker/provider/contactProvider.dart';
import 'package:provider/provider.dart';

import 'provider/authProvider.dart';
import 'provider/deviceProvider.dart';
import 'ui/pages/homePage.dart';
import 'ui/pages/onboardingPage.dart';
import 'utils/constants.dart';
import 'package:flutter/material.dart';
import 'ui/pages/authPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: AuthProvider()),
          ChangeNotifierProvider.value(value: DeviceProvider()),
          ChangeNotifierProvider.value(value: ContactProvider()),
        ],
        child: Consumer<AuthProvider>(
          builder: (context, authData, _) {
            return MaterialApp(
              title: 'Corona Tracker',
              theme: ThemeData(primaryColor: Constants.primaryColor),
              home: authData.isLoggedIn
                  ? HomePage()
                  : FutureBuilder(
                      future: authData.tryAutoLogin(),
                      builder: (context, authDataResultSnapSHot) =>
                          authDataResultSnapSHot.connectionState ==
                                  ConnectionState.waiting
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : authData.hasOnboarded
                                  ? AuthPage()
                                  : OnBoardingPage(),
                    ),
              routes: {
                HomePage.routeName: (context) => HomePage(),
                AuthPage.routeName: (context) => AuthPage()
              },
            );
          },
        ));
  }
}
