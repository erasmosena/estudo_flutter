import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:loja_virtual_gerencia/validators/login_validators.dart';
import 'package:rxdart/rxdart.dart';

enum LoginState{ IDLE, LOADING,SUCCESS, FAIL }

class LoginBloc extends BlocBase with LoginValidators{
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _stateController = BehaviorSubject<LoginState>();

  Stream<String> get outEmail => _emailController.stream.transform(validateEmail);
  Stream<String> get outPassword => _passwordController.stream.transform(validateSenha);
  Stream<LoginState> get outState => _stateController.stream;

  Stream<bool> get outSubmitValid => Rx.combineLatest2(outEmail, outPassword, (a,b)=> true );

  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changeSenha => _passwordController.sink.add;

  StreamSubscription _subscription ;
  LoginBloc()  {
    _subscription = FirebaseAuth.instance.onAuthStateChanged.listen((user)async{
      if(user != null ){
        if( await verifyPrevileges(user)){
          _stateController.add(LoginState.SUCCESS);
        }else{
          _stateController.add(LoginState.FAIL);
          FirebaseAuth.instance.signOut();
        }
      }else{
        _stateController.add(LoginState.IDLE);
      }
    });
  }

  void signOut(){
    _stateController.add(LoginState.LOADING);
    FirebaseAuth.instance.signOut();
    _stateController.add(LoginState.IDLE);
  }

  void submit(){
    final email = _emailController.value;
    final password = _passwordController.value;
    _stateController.add(LoginState.LOADING);
    FirebaseAuth.instance
    .signInWithEmailAndPassword(
      email: email, 
      password: password)
    .catchError((e){
      _stateController.add(LoginState.FAIL);
    });
  }

  Future<bool> verifyPrevileges(FirebaseUser user) async{
    return await Firestore.instance.collection("admins").document(user.uid).get()
    .then( (doc) => doc.data != null )
    .catchError((erro) => false );
  }

  @override
  void dispose(){
    _stateController.close();
    _emailController.close();
    _passwordController.close();
    _subscription.cancel();
    super.dispose();
  }
}