import 'package:flutter/material.dart';
import 'package:xlo/common/custom_drawer/custom_drawer.dart';

import 'account_edit/account_edit_screen.dart';

class AccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Minha Conta'),
        actions: <Widget>[
          FlatButton(
            child: const Text('EDITAR', style: TextStyle(color: Colors.white)),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context)=> AccountEditScreen())
              );
            },
          )
        ],
      ),
      drawer: CustomDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            height: 180,
            decoration: BoxDecoration(color: Colors.blue),
            child: Text(
              'Nome',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          ListTile(
            title: Text(
              'Meus anúncios',
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            trailing: Icon(Icons.keyboard_arrow_right),
          ),
          ListTile(
            title: Text('Favoritos',
                style:
                    TextStyle(color: Colors.blue, fontWeight: FontWeight.w600)),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            trailing: Icon(Icons.keyboard_arrow_right),
          )
        ],
      ),
    );
  }
}
