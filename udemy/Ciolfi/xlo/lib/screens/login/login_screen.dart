import 'package:flutter/material.dart';
import 'package:xlo/blocs/login/field_state.dart';
import 'package:xlo/blocs/login/login_bloc.dart';
import 'package:xlo/screens/login/widget/login_button.dart';

import 'widget/facebook_button.dart';
import 'widget/or_divider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginBloc _loginBloc = LoginBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(elevation: 0, title: const Text('Entrar')),
        body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    FacebookButton(_loginBloc),
                    OrDivider(),
                    Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 11),
                      child: Text(
                        'Acessar com E-mail:',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, color: Colors.grey[900]),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 3, bottom: 4),
                      child: Text(
                        'E-mail:',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[800],
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    StreamBuilder<FieldState>(
                      initialData: FieldState(),
                      stream: _loginBloc.outEmail,
                      builder: (context, snapshot) {
                        return TextField(
                            enabled: snapshot.data.enabled,
                            onChanged: _loginBloc.changedEmail,
                            keyboardType: TextInputType.emailAddress,
                            autocorrect: false,
                            decoration: InputDecoration(
                                errorText: snapshot.data.error,
                                border: const OutlineInputBorder()));
                      },
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 3, bottom: 4, top: 26),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text('Senha',
                                style: TextStyle(
                                    color: Colors.grey[800],
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700)),
                          ),
                          GestureDetector(
                            child: Text('Esqueceu sua senha?',
                                style: TextStyle(
                                    color: Colors.blue,
                                    decoration: TextDecoration.underline)),
                            onTap: () {
                              //recover screen
                            },
                          )
                        ],
                      ),
                    ),
                    StreamBuilder<FieldState>(
                      initialData: FieldState(),
                      stream: _loginBloc.outPassword,
                      builder: (context, snapshot) {
                        return TextField(
                            enabled: snapshot.data.enabled,
                            onChanged: _loginBloc.changedPassword,
                            obscureText: true,
                            autocorrect: false,
                            decoration: InputDecoration(
                                errorText: snapshot.data.error,
                                border: const OutlineInputBorder()));
                      },
                    ),
                    LoginButton(_loginBloc),
                    Divider(color: Colors.grey),
                    Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const Text('Não tem uma conta? ',
                                style: TextStyle(fontSize: 16)),
                            GestureDetector(
                              onTap: () {},
                              child: Text('Cadastre-se',
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: Colors.blue,
                                      fontSize: 16)),
                            )
                          ],
                        ))
                  ])),
        ));
  }
}
