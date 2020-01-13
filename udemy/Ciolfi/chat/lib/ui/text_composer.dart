import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class TextComposer extends StatefulWidget {

  final Function({String text, File imgFile}) sendMessage;

  TextComposer(this.sendMessage);
  

  @override
  _TextComposerState createState() => _TextComposerState();
}

class _TextComposerState extends State<TextComposer> {

  TextEditingController _controller = TextEditingController();
  bool _isComposing = false;

  void _reset(){
    _controller.clear();
    setState(() {
      _isComposing = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
        child: Row(
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.photo_camera),
          onPressed: () async{
            final File imgFile = await ImagePicker.pickImage(source:ImageSource.camera);
            if( imgFile == null ){
              return;
            }else{
              widget.sendMessage(imgFile:imgFile);
            }
          },
        ),
        Expanded(
          child: TextField(
            controller: _controller,
            decoration: InputDecoration(hintText: "Enviar uma mensagem"),
            onChanged: (text) {
              setState(() {
                _isComposing = text.isNotEmpty;
              });
            },
            onSubmitted: (text) {
              
              widget.sendMessage(text:text);
              _reset();
            },
          ),
        ),
        IconButton(
          icon: Icon(Icons.send),
          onPressed: _isComposing? () {
            widget.sendMessage(text:_controller.text);
            _reset();
          }:null,
        )
      ],
    ));
  }
}