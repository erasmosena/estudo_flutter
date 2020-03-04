import 'package:flutter/material.dart';
import 'package:loja_virtual_gerencia/widgets/input_field.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(Icons.store_mall_directory,
              color:Colors.pinkAccent,
              size: 160,
              ),
              InputField(
                hint: "Usuário",
                icon: Icons.person_outline,
                obscure: false,
              ),
              InputField(
                hint: "Senha",
                icon: Icons.lock_outline,
                obscure: true,
              ),
              FlatButton(
                color: Colors.pinkAccent,
                child: Text("Entrar"),
                onPressed: (){},
              )
            ],
          ),
        ),
      ),
    );
  }
}