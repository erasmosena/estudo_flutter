import 'package:flutter/material.dart';
import 'package:loja_virtual_gerencia/blocs/login_bloc.dart';
import 'package:loja_virtual_gerencia/widgets/input_field.dart';
import 'package:loja_virtual_gerencia/screens/home_screen.dart';
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _loginBloc = LoginBloc();

  @override
  void dispose() {
    _loginBloc.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _loginBloc.outState.listen((state){
      switch (state) {
        case LoginState.SUCCESS:
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => HomeScreen())
          );
          break;
        case LoginState.FAIL:
          showDialog(context: context, builder: (_) => 
          AlertDialog(
            title: Text("Erro"),
            content: Text("Você não possui privilégios necessários"),
          ));
          break;
        case LoginState.LOADING:
        case LoginState.IDLE:          
        default:
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      body: StreamBuilder<LoginState>(
          stream: _loginBloc.outState,
          initialData: LoginState.LOADING,
          builder: (context, snapshot) {
            print(snapshot.data);
            switch (snapshot.data) {
              case LoginState.LOADING:
                return Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.pinkAccent),
                  ),
                );
              case LoginState.FAIL:
              case LoginState.SUCCESS:
              case LoginState.IDLE:
              default:
                return Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Container(),
                    SingleChildScrollView(
                      child: Container(
                        margin: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Icon(
                              Icons.store_mall_directory,
                              color: Colors.pinkAccent,
                              size: 160,
                            ),
                            InputField(
                              hint: "Usuário",
                              icon: Icons.person_outline,
                              obscure: false,
                              stream: _loginBloc.outEmail,
                              onChanged: _loginBloc.changeEmail,
                            ),
                            InputField(
                              hint: "Senha",
                              icon: Icons.lock_outline,
                              obscure: true,
                              stream: _loginBloc.outPassword,
                              onChanged: _loginBloc.changeSenha,
                            ),
                            SizedBox(
                              height: 32,
                            ),
                            StreamBuilder<bool>(
                                stream: _loginBloc.outSubmitValid,
                                builder: (context, snapshot) {
                                  return SizedBox(
                                    height: 50,
                                    child: RaisedButton(
                                      disabledColor:
                                          Colors.pinkAccent.withAlpha(140),
                                      color: Colors.pinkAccent,
                                      child: Text("Entrar"),
                                      textColor: Colors.white,
                                      onPressed: snapshot.hasData
                                          ? _loginBloc.submit
                                          : null,
                                    ),
                                  );
                                })
                          ],
                        ),
                      ),
                    ),
                  ],
                );
            }
          }),
    );
  }
}
