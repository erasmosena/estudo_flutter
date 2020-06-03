
enum SignUpState { IDLE, LOADING, ERROR }

class SignUpBlocState {
  SignUpBlocState(this.state, {this.errorMessage});

  SignUpState state;
  String errorMessage;
}