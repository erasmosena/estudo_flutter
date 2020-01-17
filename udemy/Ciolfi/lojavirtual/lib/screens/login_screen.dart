import 'package:flutter/material.dart';
import 'package:lojavirtual/models/user_model.dart';
import 'package:lojavirtual/screens/recover_screen.dart';
import 'package:lojavirtual/screens/signup_screen.dart';
import 'package:scoped_model/scoped_model.dart';
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {


  TextEditingController _emailController = TextEditingController();
  TextEditingController _passController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey ,
        appBar: AppBar(
          title: Text("Entrar"),
          centerTitle: true,
          actions: <Widget>[
            FlatButton(
              child: Text(
                "Criar Conta",
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              textColor: Colors.white,
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => SignUpScreen()));
              },
            )
          ],
        ),
        body:
            ScopedModelDescendant<UserModel>(builder: (context, child, model) {
          if (model.isLoading)
            return Center(child: CircularProgressIndicator());
          else
            return Form(
              key: _formKey,
              child: ListView(
                padding: EdgeInsets.all(16),
                children: <Widget>[
                  TextFormField(
                    controller: _emailController,
                    validator: (text) {
                      if (text.isEmpty || !text.contains("@"))
                        return "E-mail inválido";
                    },
                    decoration: InputDecoration(hintText: "Email"),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    controller: _passController,
                    validator: (text) {
                      if (text.isEmpty || text.length < 6)
                        return "Senha inválido";
                    },
                    decoration: InputDecoration(hintText: "Senha"),
                    obscureText: true,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: FlatButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => RecoverScreen()));
                      },
                      child: Text(
                        "Esqueci minha senha",
                        textAlign: TextAlign.right,
                      ),
                      padding: EdgeInsets.zero,
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    height: 44,
                    child: RaisedButton(
                      child: Text(
                        "Entrar",
                        style: TextStyle(fontSize: 18),
                      ),
                      textColor: Colors.white,
                      color: Theme.of(context).primaryColor,
                      onPressed: () {
                        if ( _formKey.currentState.validate()) {
                          model.signIn(email: _emailController.text,
                          pass: _passController.text,onSuccess: _onSuccess , onFail: _onFail );  
                        }                        
                      },
                    ),
                  )
                ],
              ),
            );
        }));
  }

  void _onSuccess(){
  //  _scaffoldKey.currentState.showSnackBar(SnackBar(
  //       content: Text("Bem vindo de volta."),
  //       backgroundColor: Theme.of(context).primaryColor,
  //       duration: Duration(seconds: 2)));
  //   Future.delayed(Duration(seconds: 2)).then((_) {
      
  //   });
    Navigator.of(context).pop();
  }
  void _onFail(){
    _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text("Falha ao fazer login."),
        backgroundColor: Colors.redAccent,
        duration: Duration(seconds: 2)));
  }
}
