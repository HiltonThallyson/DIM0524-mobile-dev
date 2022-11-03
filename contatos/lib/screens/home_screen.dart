import 'package:flutter/material.dart';

import '../helpers/contact_helper.dart';
import '../model/contact.dart';
import '../widgets/contact_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Contact> contacts = [];

  @override
  void initState() {
    super.initState();
    ContactHelper()
        .getContacts()
        .then((contactList) => contacts = contactList.cast<Contact>());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contatos"),
      ),
      body: ListView.builder(
        itemCount: contacts.length,
        itemBuilder: ((context, index) => GestureDetector(
              child: ContactCard(contacts[index]),
              onTap: () => _showOptions(context, index),
            )),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).pushNamed("/contact-page"),
      ),
    );
  }

  void _showOptions(BuildContext context, int index) {
    showModalBottomSheet(
        context: context,
        builder: ((context) {
          return BottomSheet(
              onClosing: () {},
              builder: ((context) {
                return Container(
                  height: 100,
                  width: double.infinity,
                  child: Column(
                    children: [
                      TextButton(
                          onPressed: () => print("Ligando"),
                          child: const Text("Ligar")),
                      TextButton(
                          onPressed: () => print("editando"),
                          child: const Text("Editar")),
                      TextButton(
                          onPressed: () => print("excluindo"),
                          child: const Text("Excluir"))
                    ],
                  ),
                );
              }));
        }));
  }
}
