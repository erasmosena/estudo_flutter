import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {

  CustomTextField({this.hint,this.prefix, this.suffix, this.textInputType, this.onChanged, this.enable, this.obscure = false,this.controller});

  final TextEditingController controller;

  final String hint;
  final Widget prefix;
  final Widget suffix;
  final TextInputType textInputType;
  final Function(String) onChanged ;
  final bool enable;
  final bool obscure;


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(32)
      ),
      padding: prefix != null ? null: const EdgeInsets.only(left: 16),
      child: TextField(
        controller:controller,
        obscureText: obscure,
        keyboardType: textInputType,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hint,
          border: InputBorder.none,
          prefixIcon: prefix,
          suffixIcon: suffix
        ),
        textAlignVertical: TextAlignVertical.center,
      ),
    );
  }
}