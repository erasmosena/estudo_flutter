import 'package:chat/ui/text_composer.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class ChatScreen extends StatefulWidget {
  

  @override
  _ChatScreenState createState() => _ChatScreenState();
}


  void _sendMessage({String text, File imgFile})async{
    if( imgFile != null ) {
      StorageUploadTask task = FirebaseStorage.instance.ref()
      .child(DateTime.now().millisecondsSinceEpoch.toString())
      .putFile(imgFile);
      StorageTaskSnapshot taskSnapshot =  await task.onComplete;
      String url = await taskSnapshot.ref.getDownloadURL();
      
    }
    Firestore.instance.collection("message").add(
      {
        'text':text
      }
    );
  }

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Olá"),
        elevation: 0
      ),
      body: TextComposer(_sendMessage),
    );
  }

}  


