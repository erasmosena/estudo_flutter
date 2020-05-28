import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:xlo/blocs/login/button_state.dart';
import 'package:xlo/blocs/login/field_state.dart';
import 'package:xlo/blocs/login/login_bloc_state.dart';
import 'package:xlo/validators/login_validator.dart';

class LoginBloc with LoginValidator {
  final BehaviorSubject<LoginBlocState> _stateController =
      BehaviorSubject<LoginBlocState>.seeded(LoginBlocState(LoginState.IDLE));
  final BehaviorSubject<String> _emailController = BehaviorSubject<String>();
  final BehaviorSubject<String> _passwordController = BehaviorSubject<String>();

  Stream<LoginBlocState> get outState => _stateController.stream;
  Stream<FieldState> get outEmail => Rx.combineLatest2(
          _emailController.stream.transform(emailValidator), outState,
          (email, state) {
        email.enabled = state.state != LoginState.LOADING;
        return email;
      });
  Stream<FieldState> get outPassword => Rx.combineLatest2(
          _passwordController.stream.transform(passwordValidator), outState,
          (password, state) {
        password.enabled = state.state != LoginState.LOADING;
        return password;
      });
  Stream<ButtonState> get outLoginButton => Rx.combineLatest3(
      outEmail,
      outPassword,
      outState,
      (email, password, state) => ButtonState(
          loading: state.state == LoginState.LOADING,
          enabled: email.error == null &&
              password.error == null &&
              state.state != LoginState.LOADING));

  Function(String) get changedEmail => _emailController.sink.add;
  Function(String) get changedPassword => _passwordController.sink.add;

  void loginWithEmail() async {
    _stateController.add(LoginBlocState(LoginState.LOADING));
    await Future.delayed(Duration(seconds: 3));
    _stateController.add(LoginBlocState(LoginState.IDLE));
  }

  void loginWithFacebook() async {
    _stateController.add(LoginBlocState(LoginState.LOADING_FACE));
    await Future.delayed(Duration(seconds: 3));
    _stateController.add(LoginBlocState(LoginState.IDLE));
  }

  void dispose() {
    _stateController.close();
    _emailController.close();
    _passwordController.close();
  }
}
