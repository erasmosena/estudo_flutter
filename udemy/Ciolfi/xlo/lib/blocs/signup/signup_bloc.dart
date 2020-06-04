import 'package:rxdart/rxdart.dart';
import 'package:xlo/blocs/signup/signup_bloc_state.dart';
import 'package:xlo/models/user.dart';

class SignUpBloc {
  User user = User();
  BehaviorSubject<SignUpBlocState> _stateController =
      BehaviorSubject.seeded(SignUpBlocState(SignUpState.IDLE));

  Stream<SignUpBlocState> get outState => _stateController.stream;

  void signUp() async  {
    _stateController.add(SignUpBlocState(SignUpState.LOADING));
    await Future.delayed(Duration(seconds: 5));
    _stateController.add(SignUpBlocState(SignUpState.IDLE));
  }

  void setName(String name) {
    user.name = name;
  }

  void setEmail(String email) {
    user.email = email;
  }

  void setPassword(String password) {
    user.password = password;
  }

  void dispose() {
    _stateController.close();
  }
}
