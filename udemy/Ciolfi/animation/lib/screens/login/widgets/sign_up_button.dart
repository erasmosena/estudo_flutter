import 'package:flutter/material.dart';

class SingUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: () {},
      padding: const EdgeInsets.only(top: 160),
      child: Text(
        "Não possui uma conta? Cadastre-se",
        style: TextStyle(
            fontWeight: FontWeight.w300, color: Colors.white, fontSize: 12, letterSpacing: 0.5),
      ),
    );
  }
}
