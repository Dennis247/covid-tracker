import 'package:covid_tracker/model/contactModel.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class ContactWidget extends StatelessWidget {
  final Contact contact;

  const ContactWidget({Key key, this.contact}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(contact.imageUrl),
        ),
        title: Text(contact.displayName),
        subtitle: Text(contact.email),
        trailing: Text(timeago.format(contact.conatctDate)),
      ),
    );
  }
}
