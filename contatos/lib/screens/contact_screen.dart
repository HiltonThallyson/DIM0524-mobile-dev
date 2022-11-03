import 'package:flutter/material.dart';

import '../model/contact.dart';

class ContactScreen extends StatefulWidget {
  Contact? _contact;

  ContactScreen([this._contact]);

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("widget._contact?.name ?? Contact()")),
    );
  }
}
