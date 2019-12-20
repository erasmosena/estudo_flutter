
import 'package:flutter/material.dart';

void main() => runApp(ConfiguracaoPage());

class ConfiguracaoPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: Perfil(),
    );
  }
}

class Perfil extends StatefulWidget {
  @override
  PerfilState createState() => PerfilState();
}

class PerfilState extends State {
  void _pushBackAction() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Configurações',
        ),
        leading:IconButton(
              icon: Icon(Icons.keyboard_backspace),
              onPressed: _pushBackAction,
              alignment: Alignment.centerLeft),
        actions: <Widget>[
          
        ],
      ),
      body: _pageBody(),
    );
  }

  Widget _pageBody() {
    return ListView(
      children: <Widget>[
        Card(
          child: ListTile(
            leading: FlutterLogo(size: 56.0),
            title: Text('Clone Whats Layout'),
            subtitle: Text('Ficou igualzinho, hein?!'),
          ),
        ),
        Card(
          child: ListTile(
            leading: Icon(Icons.security),
            title: Text('Conta'),
            subtitle: Text('Privacidade, segurança, mudar número'),
          ),
        ),
        Card(
          child: ListTile(
            leading: Icon(Icons.message),
            title: Text('Conversas'),
            subtitle: Text('Privacidade, segurança, mudar número'),
          ),
        ),
        Card(
          child: ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Notificações'),
            subtitle: Text('Privacidade, segurança, mudar número'),
          ),
        ),
        Card(
          child: ListTile(
            leading: Icon(Icons.data_usage),
            title: Text('Uso de dados e armazenamento'),
            subtitle: Text('Privacidade, segurança, mudar número'),
          ),
        ),
        Card(
          child: ListTile(
            leading: Icon(Icons.help_outline),
            title: Text('Ajuda'),
            subtitle: Text('Privacidade, segurança, mudar número'),
          ),
        ),
        Card(
          child: ListTile(
            leading: Icon(Icons.group),
            title: Text('Convidar um amigo'),
            subtitle: Text('Privacidade, segurança, mudar número'),
          ),
        ),
      ],
    );
  }
}
