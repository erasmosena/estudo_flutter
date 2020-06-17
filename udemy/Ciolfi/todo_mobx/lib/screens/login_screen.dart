import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:todo_mobx/store/login_store.dart';
import 'package:todo_mobx/widget/custo_text_field.dart';
import 'package:todo_mobx/widget/custom_icon_button.dart';


class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginStore loginStore = LoginStore();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.all(32),
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
            elevation: 16,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Observer(
                    builder: (_) {
                      return CustomTextField(
                        hint: 'Email',
                        prefix: Icon(Icons.account_circle),
                        textInputType: TextInputType.emailAddress,
                        onChanged: loginStore.setEmail,
                        enabled: !loginStore.isLoading,
                      );
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Observer(
                    builder: (_) {
                      return CustomTextField(
                          hint: 'Senha',
                          prefix: Icon(Icons.lock),
                          obscure: loginStore.isObscure,
                          onChanged: loginStore.setPassword,
                          enabled: !loginStore.isLoading,
                          suffix: CustomIconButton(
                              radius: 32,
                              iconData: loginStore.isObscure
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              onTap: loginStore.toggleObscure));
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    height: 44,
                    child: Observer(builder: (_) {
                      return RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32)),
                        child: loginStore.isLoading
                            ? CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              )
                            : Text('Login'),
                        color: Theme.of(context).primaryColor,
                        disabledColor:
                            Theme.of(context).primaryColor.withAlpha(100),
                        textColor: Colors.white,
                        onPressed: loginStore.isFormValid
                            ? () {
                                loginStore.login();
                              }
                            : null,
                      );
                    }),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
