import 'package:covid_tracker/model/contactModel.dart';
import 'package:covid_tracker/ui/pages/contactPage.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:covid_tracker/utils/styles.dart';

class ContactWidget extends StatelessWidget {
  final Contact contact;

  const ContactWidget({Key key, this.contact}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return ContactPage(contact: contact);
        }));
      },
      child: Card(
        elevation: 3,
        child: ListTile(
          leading: Hero(
            tag: contact.contactId,
            child: CircleAvatar(
              backgroundImage: NetworkImage(contact.imageUrl),
            ),
          ),
          title: Text(
            contact.displayName,
            style: AppStyle.mediumTextSTyle,
          ),
          subtitle: Text(
            contact.email,
            style: AppStyle.smallTextStyle,
          ),
          trailing: Text(
            timeago.format(contact.conatctDate),
            style: AppStyle.smallTextStyle,
          ),
        ),
      ),
    );
  }
}
