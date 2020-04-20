import 'package:covid_tracker/model/contactModel.dart';
import 'package:covid_tracker/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class ContactPage extends StatelessWidget {
  final Contact contact;
  const ContactPage({Key key, this.contact}) : super(key: key);

  _buildRowWidget(String title, String subTitle, IconData iconData) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(
                iconData,
                color: Colors.blueGrey,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                title,
                style: AppStyle.mediumTextSTyle,
              )
            ],
          ),
          Row(
            children: <Widget>[
              SizedBox(
                width: 35,
              ),
              Text(
                subTitle,
                style: AppStyle.smallTextStyle,
              )
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    DateFormat dateFormat = DateFormat("yyyy-MM-dd ").add_jm();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Contact Details",
          style: AppStyle.headerTextStyle,
        ),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                child: Hero(
                  tag: contact.contactId,
                  child: CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(contact.imageUrl),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                contact.displayName,
                textAlign: TextAlign.center,
                style: AppStyle.mediumTextSTyle,
              ),
              Text(
                contact.email,
                textAlign: TextAlign.center,
                style: AppStyle.smallTextStyle,
              ),
              SizedBox(
                height: 30,
              ),
              _buildRowWidget(dateFormat.format(contact.conatctDate), "Date",
                  FontAwesomeIcons.clock),
              _buildRowWidget("${contact.distance.toString()} Meters",
                  "Distance", FontAwesomeIcons.running),
              _buildRowWidget(
                  "Latitude : ${contact.latitude.toString()}\nLongitude :${contact.longitude.toString()}",
                  "place of contact",
                  FontAwesomeIcons.globe),
            ],
          ),
        ),
      ),
    );
  }
}
