import 'package:brasil_fields/formatter/telefone_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:xlo/models/user.dart';
import 'package:xlo/screens/account/account_edit/widget/user_type.dart';

class AccountEditScreen extends StatefulWidget {
  @override
  _AccountEditScreenState createState() => _AccountEditScreenState();
}

class _AccountEditScreenState extends State<AccountEditScreen> {
  final User user = User();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text('Editar Conta'),
        ),
        body: ListView(
            padding: const EdgeInsets.only(left: 16, bottom: 8, top: 8),
            children: <Widget>[
              UserTypeWidget(initialValue: user.userType,onSaved: (value){

              },),
              TextFormField(
                initialValue: user.name,
                validator: (name) {
                  if (name.length < 6) {
                    return 'Nome inválido';
                  }
                  return null;
                },
                onSaved: (name) {
                  user.name = name;
                },
                decoration: _buildDecoration('Nome *'),
              ),
              TextFormField(
                initialValue: user.phone,
                validator: (telefone) {
                  if (telefone.length < 15) {
                    return 'Telefone inválido';
                  }
                  return null;
                },
                keyboardType: TextInputType.phone,
                inputFormatters: [
                  WhitelistingTextInputFormatter.digitsOnly,
                  TelefoneInputFormatter()
                ],
                onSaved: (phone) {
                  user.phone = phone;
                },
                decoration: _buildDecoration('Telefone *'),
              ),
              TextFormField(
                autovalidate: true,
                obscureText: true,
                validator: (pass) {
                  if (pass.isEmpty) return null;
                  if (pass.length < 6) return 'Senha muito curta';
                  return null;
                },
                decoration: _buildDecoration('Nova senha'),
              ),
              TextFormField(
                validator: (passConfirm) {
                  if (passConfirm.isEmpty) return null;
                  if (passConfirm.length < 6) return 'Senha muito curta';
                  //if (passConfirm.length < 6) return 'Senha muito curta';
                  return null;
                },
                decoration: _buildDecoration('Repita nova senha'),
              ),
            ]));
  }

  InputDecoration _buildDecoration(String label) {
    return InputDecoration(
        labelText: label,
        contentPadding: const EdgeInsets.only(left: 16, bottom: 8, top: 8));
  }
}
