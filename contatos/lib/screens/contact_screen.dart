import 'dart:io';

import 'package:flutter/material.dart';

import '../model/contact.dart';

class ContactScreen extends StatefulWidget {
  static const route = "/contact-screen";
  Contact? _contact;

  ContactScreen([this._contact]);

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget._contact == null) {
      _nameController.text = "";
      _emailController.text = "";
      _phoneController.text = "";
    } else {
      _nameController.text = widget._contact!.name;
      _emailController.text = widget._contact!.email;
      _phoneController.text = widget._contact!.phone;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text(widget._contact?.name ?? "Adicionar Contato")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {},
                child: CircleAvatar(
                  maxRadius: 80,
                  minRadius: 80,
                  backgroundImage: widget._contact == null
                      ? const AssetImage("assets/images/person.png")
                      : FileImage(File(widget._contact!.image))
                          as ImageProvider,
                ),
              ),
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: "Nome",
                ),
                onSubmitted: (value) {
                  setState(() {
                    _nameController.text = value;
                  });
                },
              ),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: "Email",
                ),
                onChanged: (value) {
                  setState(() {
                    _emailController.text = value;
                  });
                },
              ),
              TextField(
                controller: _phoneController,
                decoration: const InputDecoration(
                  labelText: "Phone",
                ),
                onChanged: (value) {
                  setState(() {
                    _phoneController.text = value;
                  });
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
