import 'package:flutter/material.dart';
import 'package:xlo/blocs/signup/signup_bloc.dart';
import 'package:xlo/blocs/signup/signup_bloc_state.dart';
import 'package:xlo/screens/signup/widget/field_title.dart';
import 'package:xlo/screens/signup/widget/password_field.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  SignUpBloc _signUpBloc;

  @override
  void initState() {
    super.initState();
    _signUpBloc = SignUpBloc();
  }

  @override
  void dispose() {
    _signUpBloc?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Cadastrar'),
      ),
      body: Form(
        key: _key,
        child: StreamBuilder<SignUpBlocState>(
            stream: _signUpBloc.outState,
            initialData: SignUpBlocState(SignUpState.IDLE),
            builder: (context, snapshot) {
              return ListView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                children: <Widget>[
                  const FieldTitle(
                      title: 'Apelido',
                      subTitle: 'Como aparecerá em seus anúncios'),
                  TextFormField(
                    onSaved: _signUpBloc.setName,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Exemplo: João s'),
                    validator: (text) {
                      if (text.length < 4) {
                        return 'Apelido muito curto';
                      }
                      return null;
                    },
                    enabled: snapshot.data.state != SignUpState.LOADING,
                  ),
                  const SizedBox(
                    height: 26,
                  ),
                  const FieldTitle(
                      title: 'E-mail',
                      subTitle: 'Enviaremos um email de confirmação'),
                  TextFormField(
                    onSaved: _signUpBloc.setEmail,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    validator: (text) {
                      if (text.length < 6 || !text.contains("@")) {
                        return 'E-mail inválido';
                      }
                      return null;
                    },
                    enabled: snapshot.data.state != SignUpState.LOADING,
                  ),
                  const SizedBox(
                    height: 26,
                  ),
                  const FieldTitle(
                      title: 'Senha',
                      subTitle: 'Use letras, números e caracteres especiais'),
                  PasswordField(
                    enabled: snapshot.data.state != SignUpState.LOADING,
                    onSaved: _signUpBloc.setPassword,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 24),
                    height: 50,
                    child: RaisedButton(
                      color: Colors.pink,
                      disabledColor: Colors.pink.withAlpha(150),
                      child: snapshot.data.state == SignUpState.LOADING
                          ? CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            )
                          : Text('Cadastre-se',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600)),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)),
                      onPressed: snapshot.data.state != SignUpState.LOADING
                          ? _signUp
                          : null,
                    ),
                  ),
                  Divider(
                    color: Colors.grey,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text(
                          'Já tem uma conta?',
                          style: TextStyle(fontSize: 16),
                          
                        ),GestureDetector(
                          onTap: (){
                            Navigator.of(context).pop();
                          },
                          child: Text('Entrar', style:TextStyle(decoration:TextDecoration.underline, color: Colors.blue, fontSize: 16)),
                        )
                      ],
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }

  void _signUp() {
    if (_key.currentState.validate()) {
      _key.currentState.save();
      _signUpBloc.signUp();
    }
  }
}
