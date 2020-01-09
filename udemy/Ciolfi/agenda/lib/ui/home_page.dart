import 'dart:io';

import 'package:agenda/helpers/contat_helper.dart';
import 'package:agenda/ui/contact_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ContactHelper helper = ContactHelper();
  List<Contact> _contacts = List();
  @override
  void initState() {
    super.initState();
    _getAallContacts();
  }

  void _getAallContacts() {
    helper.getAll().then((data) {
      setState(() {
        _contacts = data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text(""),
          centerTitle: true,
          backgroundColor: Colors.red,
        ),
        body: ListView.builder(
          padding: EdgeInsets.all(10),
          itemCount: _contacts.length,
          itemBuilder: (_, index) {
            Contact contacto = _contacts[index];
            return _getContactCard(_, contacto);
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _showContactPage();
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.red,
        ),
      ),
    );
  }

  Widget _getContactCard(BuildContext context, Contact contacto) {
    return GestureDetector(
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            children: <Widget>[
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: contacto.img != null && contacto.img.isNotEmpty
                            ? FileImage(File(contacto.img))
                            : AssetImage("images/person.png"))),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      contacto.name ?? "",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      contacto.email ?? "",
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      contacto.phone ?? "",
                      style: TextStyle(fontSize: 22),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      onTap: () {
        _showContactPage(contato: contacto);
      },
    );
  }

  void _showContactPage({Contact contato}) async {
    final recContact = await Navigator.push(context,
        MaterialPageRoute(builder: (_) => ContactPage(contact: contato)));
    if (recContact != null) {
      if (contato != null) {
        await helper.update(recContact);
      } else {
        await helper.save(recContact);
      }
      _getAallContacts();
    }
  }
}
