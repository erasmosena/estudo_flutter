import 'package:chat/ui/text_composer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

import 'package:google_sign_in/google_sign_in.dart';

import 'chat_message.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GoogleSignIn googleSignIn = GoogleSignIn();
  FirebaseUser _currentUser;
  String _title = "Chat App";
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    login().then((data) => print(data));
    FirebaseAuth.instance.onAuthStateChanged.listen((user) {
      setState(() {
        _currentUser = user;
        _title = _currentUser == null ? "Chat App " : _currentUser.displayName;
      });
    });
  }

  Future login() async {
    try {
      final FirebaseUser user = await _getUser();
    } catch (e) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text("${e.toString()}"),
        backgroundColor: Colors.red,
      ));
    }
  }

  Future<FirebaseUser> _getUser() async {
    if (_currentUser != null) return _currentUser;
    try {
      final GoogleSignInAccount googleSignInAccount =
          await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      final AuthCredential authCredential = GoogleAuthProvider.getCredential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);
      final AuthResult authResult =
          await FirebaseAuth.instance.signInWithCredential(authCredential);
      final FirebaseUser user = authResult.user;
      if (user == null) throw Exception("Não foi possível fazer o login");
      return user;
    } catch (error) {
      throw error;
    }
  }

  void _sendMessage({String text, File imgFile}) async {
    Map<String, dynamic> data = {
      "uid": _currentUser.uid,
      "senderName": _currentUser.displayName,
      "senderPhotoUrl": _currentUser.photoUrl,
      "time":Timestamp.now()
    };
    if (imgFile != null) {
      setState(() {
        isLoading = true;
      });
      StorageUploadTask task = FirebaseStorage.instance
          .ref()
          .child("${_currentUser.uid}${DateTime.now().millisecondsSinceEpoch.toString()}")
          .putFile(imgFile);
      StorageTaskSnapshot taskSnapshot = await task.onComplete;
      String url = await taskSnapshot.ref.getDownloadURL();
      data["imgUrl"] = url;
      setState(() {
        isLoading = false;
      });
    }
    if (text != null) data["text"] = text;

    Firestore.instance.collection("message").add(data);
  }

  @override
  Widget build(BuildContext context) {
    Widget iconLogout = _currentUser != null ?
      IconButton(
        icon: Icon(Icons.exit_to_app),
        onPressed: _logout,
      ):Container();
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: Text("$_title"), 
        elevation: 0,
        actions: <Widget>[
          iconLogout
        ],),
      body: Column(
        children: <Widget>[
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance.collection("message").orderBy("time").snapshots(),
              //initialData: initialData ,
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.none:
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                    break;
                  default:
                    List<DocumentSnapshot> documents =
                        snapshot.data.documents.reversed.toList();
                    return ListView.builder(
                      itemCount: documents.length,
                      reverse: true,
                      itemBuilder: (context, index) {
                        return ChatMessage(documents[index].data,
                            documents[index].data["uid"] == _currentUser.uid);
                      },
                    );
                }
              },
            ),
          ),
          isLoading? LinearProgressIndicator():Container(),
          TextComposer(_sendMessage),
        ],
      ),
    );
  }

  _logout(){
    FirebaseAuth.instance.signOut();
          googleSignIn.signOut();
    _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text("Você saiu da sua conta."),
      ));
  }
}
