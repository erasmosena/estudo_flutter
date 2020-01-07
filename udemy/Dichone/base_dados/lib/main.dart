import 'package:base_dados/util/bdUtil.dart';
import 'package:flutter/material.dart';

import 'models/usuario.dart';

void main() async {
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'B-Dados',
      home: MyHomePage(title: 'B-Dados'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  void populate()async {

    var db = DataBaseSingleton();
    //populate 
    int usuarioSalvo =  await db.inserirUsuario(Usuario("Ana","1"));
    debugPrint("usuario salvo $usuarioSalvo");
    usuarioSalvo =  await db.inserirUsuario(Usuario("pedro","2"));
    debugPrint("usuario salvo $usuarioSalvo");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    populate();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black38,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[],
        ),
      ),
    );
  }
}
