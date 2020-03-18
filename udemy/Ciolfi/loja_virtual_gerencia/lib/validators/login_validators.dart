import 'dart:async';

class LoginValidators {

  

  final validateEmail =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    RegExp regExp = new RegExp(
      r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*|(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*)@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])",
      caseSensitive: false,
      multiLine: false,
    );
    if (regExp.hasMatch(email))
      sink.add(email);
    else
      sink.addError("Insira um email válido");
  });

  final validateSenha =
      StreamTransformer<String, String>.fromHandlers(handleData: (senha, sink) {
    RegExp regExp = new RegExp(
      r"[a-zA-Z0-9]{4,}",
      caseSensitive: false,
      multiLine: false,
    );
    if (regExp.hasMatch(senha))
      sink.add(senha);
    else
      sink.addError("4 ou mais caracteres(letras e números)");
  });
}
