import 'package:flutter/material.dart';
import 'package:lojavirtual/models/user_model.dart';
import 'package:lojavirtual/screens/recover_screen.dart';
import 'package:lojavirtual/screens/signup_screen.dart';
import 'package:scoped_model/scoped_model.dart';
class RecoverScreen extends StatefulWidget {
  @override
  _RecoverScreenState createState() => _RecoverScreenState();
}

class _RecoverScreenState extends State<RecoverScreen> {


  TextEditingController _emailController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey ,
        appBar: AppBar(
          title: Text("Recuperar Senha"),
          centerTitle: true,
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
                          model.recoverPass(email:_emailController.text, onSuccess: _onSuccess, onFail: _onFail );
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
   _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text("Um email foi enviado para o endereço informado, verifique sua caixa de entrada."),
        backgroundColor: Theme.of(context).primaryColor,
        duration: Duration(seconds: 5)));
    Future.delayed(Duration(seconds: 5)).then((_) {
      
    });
    Navigator.of(context).pop();
  }
  void _onFail(){
    _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text("Algo deu errado, tente novamente."),
        backgroundColor: Colors.redAccent,
        duration: Duration(seconds: 2)));
  }
}
