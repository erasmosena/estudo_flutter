import 'package:flutter/material.dart';

import 'atividades_page.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Atividades"),
        backgroundColor: Colors.black54,
      ),
      body: AtividadesPage(),
      
    );
  }
}