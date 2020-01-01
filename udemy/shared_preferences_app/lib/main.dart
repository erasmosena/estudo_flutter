import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shared Prefs',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Shared Prefs'),
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
  TextEditingController _dadosControl = TextEditingController();
  String _dadosSalvos = "";

  @override
  void initState() {
    super.initState();
    _pegarDados();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          backgroundColor: Colors.deepOrange,
          centerTitle: true,
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              TextField(
                controller: _dadosControl,
                decoration: InputDecoration(
                  labelText: 'Escreva algo'
                ),
              ),
              Padding(padding: EdgeInsets.all(10),),
              FlatButton(
                color: Colors.redAccent,
                onPressed: (){
                  _salvarDados(_dadosControl.text);
                },
                child: Text(
                  'Salvar Dados'
                ),
              ),
              Text('$_dadosSalvos')

            ],
          ),
        ));
  }

  void _pegarDados() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String pref = preferences.getString('dados');
    setState(() {
      if( pref!= null && pref.isNotEmpty){
        _dadosSalvos = pref;
      }else{
        _dadosSalvos = "vazio";
      }

    });
  }

  void _salvarDados(String mensagem) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("dados", mensagem);
  }
}
