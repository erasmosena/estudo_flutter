import 'dart:io';

import 'package:agenda/helpers/contat_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class ContactPage extends StatefulWidget {
  final Contact contact;

  ContactPage({this.contact});

  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _userEdited = false;

  Contact _editedContact;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.contact == null) {
      _editedContact = Contact();
    } else {
      _editedContact = Contact.fromMap(widget.contact.toMap());
      _nameController.text = _editedContact.name;
      _emailController.text = _editedContact.email;
      _phoneController.text = _editedContact.phone;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _requestPop,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.red,
            title: Text(_editedContact?.name ?? "Novo Contato"),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(10),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  GestureDetector(
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: _editedContact.img != null &&
                                      _editedContact.img.isNotEmpty
                                  ? FileImage(File(_editedContact.img))
                                  : AssetImage("images/person.png"))),
                    ),
                    onTap: _getImage,
                  ),
                  Divider(),
                  TextFormField(
                    validator: (value) {
                      return value.isEmpty ? "Campo Requerido" : null;
                    },
                    controller: _nameController,
                    decoration: InputDecoration(labelText: "Nome"),
                    onChanged: (text) {
                      _userEdited = true;
                      setState(() {
                        _editedContact.name = text;
                      });
                    },
                  ),
                  Divider(),
                  TextFormField(
                    validator: (value) {
                      return value.isEmpty ? "Campo Requerido" : null;
                    },
                    controller: _emailController,
                    decoration: InputDecoration(labelText: "Email"),
                    onChanged: (text) {
                      _userEdited = true;
                      _editedContact.email = text;
                    },
                    keyboardType: TextInputType.emailAddress,
                  ),
                  Divider(),
                  TextFormField(
                      validator: (value) {
                        return value.isEmpty ? "Campo Requerido" : null;
                      },
                      controller: _phoneController,
                      decoration: InputDecoration(labelText: "Phone"),
                      onChanged: (text) {
                        _userEdited = true;
                        _editedContact.phone = text;
                      },
                      keyboardType: TextInputType.phone)
                ],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              if (_formKey.currentState.validate()) {
                Navigator.pop(context, _editedContact);
              }
              //FocusScope.of(context).requestFocus(_nameFocus);
            },
            child: Icon(Icons.save),
            backgroundColor: Colors.red,
          ),
        ));
  }

  _getImage() async {
    _showOptionsImageCapture(context);
  }

  Future<ImageSource> _showOptionsImageCapture(BuildContext context) async {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return BottomSheet(
              onClosing: () {},
              builder: (BuildContext context) {
                return Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      FlatButton(
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.camera_alt),
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Text(
                                "Camera",
                                style: TextStyle(color: Colors.red, fontSize: 20),
                              ),
                            )
                          ],
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          ImagePicker.pickImage(source: ImageSource.camera)
                              .then((file) {
                            if (file == null) {
                              return;
                            } else {
                              setState(() {
                                _editedContact.img = file.path;
                              });
                            }
                          });
                        },
                      ),
                      Divider(),
                      FlatButton(
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.photo),
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Text(
                                "Galeria",
                                style: TextStyle(color: Colors.red, fontSize: 20),
                              ),
                            ),
                          ],
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          ImagePicker.pickImage(source: ImageSource.gallery)
                              .then((file) {
                            if (file == null) {
                              return;
                            } else {
                              setState(() {
                                _editedContact.img = file.path;
                              });
                            }
                          });
                        },
                      ),
                    ],
                  ),
                );
              });
        });
  }

  Future<bool> _requestPop() {
    if (_userEdited) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Descartar Alterações?"),
              content: Text("Se sair as alterações serão perdidas"),
              actions: <Widget>[
                FlatButton(
                  child: Text("Cancelar"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                FlatButton(
                  child: Text("Ok"),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                )
              ],
            );
          });
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }
}
