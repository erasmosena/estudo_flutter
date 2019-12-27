
import 'package:flutter/material.dart';
import 'package:whats_clone/ui/home.dart';

void main() => runApp(ConfiguracaoPage());

class ConfiguracaoPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: HomePage(),
    );
  }
}
