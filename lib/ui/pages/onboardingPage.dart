import 'package:covid_tracker/utils/constants.dart';
import 'package:covid_tracker/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'authPage.dart';

class OnBoardingPage extends StatefulWidget {
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  Container _buildOnboardingPages(
      String imagePath, String introText, int pageNo, bool isFinalPage) {
    return Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.6,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                      image: AssetImage(imagePath), fit: BoxFit.contain)),
            ),
            Text(
              introText,
              style: AppStyle.mediumTextSTyle,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              pageNo.toString(),
              style: AppStyle.largeTextSTyle,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            isFinalPage
                ? SizedBox(
                    height: 48,
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: MaterialButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushReplacementNamed(AuthPage.routeName);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            FontAwesomeIcons.play,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Get Started",
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                      color: Constants.primaryColor,
                    ),
                  )
                : Text("")
          ],
        ));
  }

  List<Container> _getonBoardingList() {
    return [
      _buildOnboardingPages("assets/images/1.png", "Sign Up", 1, false),
      _buildOnboardingPages("assets/images/2.png",
          "Records Contacts less than 6 meters", 2, false),
      _buildOnboardingPages("assets/images/3.png", "Track Contacts", 3, true)
    ];
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        home: new Scaffold(
            body: LiquidSwipe(
      pages: _getonBoardingList(),
      enableSlideIcon: true,
      positionSlideIcon: 0.2,
      fullTransitionValue: 500,
      enableLoop: false,
      waveType: WaveType.liquidReveal,
    )));
  }
}
