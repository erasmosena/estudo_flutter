import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String hint;
  final bool obscure;
  final IconData icon;
  final Stream<String> stream;
  final Function(String) onChanged;

  InputField({this.hint, this.icon, this.obscure, this.stream,this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border:
              Border(bottom: BorderSide(color: Colors.white24, width: 0.5))),
      child: StreamBuilder<String>(
        stream: stream,
        builder: (context, snapshot) {
          return TextField(
            onChanged: onChanged,
            obscureText: obscure,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
                icon: Icon(
                  icon,
                  color: Colors.white,
                ),
                border: InputBorder.none,
                hintText: hint,
                errorText: snapshot.hasError?snapshot.error:null,
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.pinkAccent)),
                hintStyle: TextStyle(color: Colors.white, fontSize: 15),
                contentPadding:
                    const EdgeInsets.only(top: 30, right: 30, bottom: 30, left: 5)),
          );
        }
      ),
    );
  }
}
