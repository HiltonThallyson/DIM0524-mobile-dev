import 'dart:io';

import 'package:flutter/material.dart';

import '../model/contact.dart';

class ContactCard extends StatelessWidget {
  final Contact contact;

  ContactCard(this.contact);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: contact.image == ""
          ? Image.asset("/assets/images/person.png")
          : Image.file(File(contact.image)),
      title: Column(
        children: [
          Text(contact.name),
          Text(contact.email),
          Text(contact.phone),
        ],
      ),
    );
  }
}
