import 'package:flutter/material.dart';
import 'package:todo_mobx/widget/custo_text_field.dart';
import 'package:todo_mobx/widget/custom_icon_button.dart';

import 'list_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.all(32),
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
            elevation: 16,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  CustomTextField(
                    hint: 'Email',
                    prefix: Icon(Icons.account_circle),
                    textInputType: TextInputType.emailAddress,
                    onChanged: (text) {},
                    enable: true,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  CustomTextField(
                      hint: 'Senha',
                      prefix: Icon(Icons.lock),
                      obscure: true,
                      onChanged: (text) {},
                      enable: true,
                      suffix: CustomIconButton(
                          radius: 32,
                          iconData: Icons.visibility,
                          onTap: () {})),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    height: 44,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32)),
                          child: Text('Login'),
                          color: Theme.of(context).primaryColor,
                          disabledColor: Theme.of(context).primaryColor.withAlpha(100),
                          textColor: Colors.white,
                          onPressed: (){
                            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>ListScreen()));
                          },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
