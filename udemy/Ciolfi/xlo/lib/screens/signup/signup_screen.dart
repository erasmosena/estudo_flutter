import 'package:flutter/material.dart';
import 'package:xlo/screens/signup/widget/field_title.dart';
import 'package:xlo/screens/signup/widget/password_field.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Cadastrar'),
      ),
      body: Form(
        key: _key,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          children: <Widget>[
            const FieldTitle(title:'Apelido',subTitle:'Como aparecerá em seus anúncios'),
            TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Exemplo: João s'
              ),
              validator: (text){
                if( text.length < 4){
                  return 'Apelido muito curto';
                }
                return null ; 
              },
            ),
            const SizedBox(height: 26,),
            const FieldTitle(title:'E-mail',subTitle:'Enviaremos um email de confirmação'),
            TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
              validator: (text){
                if( text.length < 6 || !text.contains("@")){
                  return 'E-mail inválido';
                }
                return null ; 
              },
            ),
            const SizedBox(height: 26,),
            const FieldTitle(title:'Senha',subTitle:'Use letras, números e caracteres especiais'),
            PasswordField(),
          ],
        ),
      ),
    );
  }
}
