import 'dart:async';


import 'package:rxdart/rxdart.dart';
import 'package:xlo/blocs/login/field_state.dart';
import 'package:xlo/blocs/login/login_bloc_state.dart';
import 'package:xlo/validators/login_validator.dart';

class LoginBloc with LoginValidator{
  final BehaviorSubject<LoginBlocState> _stateController = BehaviorSubject<LoginBlocState>
  .seeded(LoginBlocState(LoginState.IDLE));
  final BehaviorSubject<String> _emailController = BehaviorSubject<String>();
  final BehaviorSubject<String> _passwordController = BehaviorSubject<String>();
  

  Stream<LoginBlocState> get outState => _stateController.stream;
  Stream<FieldState> get outEmail => _emailController.stream.transform(emailValidator);
  Stream<FieldState> get outSenha => _passwordController.stream.transform(passwordValidator);

  Function(String) get changedEmail => _emailController.sink.add;
  Function(String) get changedPassword => _passwordController.sink.add;

  

  void dispose(){
    _stateController.close();
    _emailController.close();
    _passwordController.close();
  }
}