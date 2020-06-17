import 'package:mobx/mobx.dart';

part 'login_store.g.dart';

class LoginStore = _LoginStore with _$LoginStore;

abstract class _LoginStore with Store{

  // _LoginStore(){
  //   autorun((_){
  //     print(isObscure);
  //   });
  // }

  Pattern pattern =
            r"^(([^<>()[\]\\.,;:\s@\']+(\.[^<>()[\]\\.,;:\s@\']+)*)|(\'.+\'))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$";

  @observable
  String email = ""; 
  @observable
  String password = "";

  @observable
  bool isObscure = true;

  @observable
  bool isLoading = false;



  @action 
  void toggleObscure( )=> isObscure = !isObscure ; 

  @action 
  void setEmail(String value )=> email = value ; 

  @action 
  void setPassword(String value )=> password = value ; 

  @action 
  Future<void> login() async { 
    isLoading = true;
    await Future.delayed(Duration(seconds: 5));
    isLoading = false;
  }




  @computed
  bool get isPasswordValid =>  password.length >= 6 ;
  
  @computed
  bool get isEmailValid =>  
  RegExp(pattern).hasMatch(email) ;

  @computed
  bool get isFormValid => isEmailValid && isPasswordValid;

}