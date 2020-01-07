import 'package:app_fire_base/models/comunidade.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Comunidade'),
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
  final FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference databaseReference;
  Comunidade comunidade;
  List<Comunidade> _mensagensComunidade = List();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    comunidade = new Comunidade("", "");
    databaseReference = database.reference().child("comunidade");
    databaseReference.onChildAdded.listen(_handleMessage);
    databaseReference.onChildChanged.listen(_handleChange);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          Flexible(
            flex: 0,
            child: Center(
              child: Form(
                key: formKey,
                child: Flex(
                  direction: Axis.vertical,
                  children: <Widget>[
                    ListTile(
                      leading: Icon(Icons.subject),
                      title: TextFormField(
                        initialValue: "",
                        onSaved: (val) => comunidade.assunto = val,
                        validator: (val) => val == "" ? val : null,
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.message),
                      title: TextFormField(
                        initialValue: "",
                        onSaved: (val) => comunidade.mensagem = val,
                        validator: (val) => val == "" ? val : null,
                      ),
                    ),
                    FlatButton(
                      onPressed: () {
                        _handleSubmit();
                      },
                      child: Text("Postar"),
                      color: Colors.redAccent,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Flexible(
            child: FirebaseAnimatedList(
              query: databaseReference,
              itemBuilder: (_, DataSnapshot snapshot, 
              Animation<double> animation, int posicao ){
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.red,
                    ),
                    title: Text(_mensagensComunidade[posicao].assunto),
                    subtitle: Text(_mensagensComunidade[posicao].mensagem),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _handleMessage(Event event) {
    setState(() {
      _mensagensComunidade.add(Comunidade.fromSnapshot(event.snapshot));
    });
  }

  void _handleSubmit() {
    final FormState form = formKey.currentState;
    if (form.validate()) {
      form.save();
      form.reset();
      databaseReference.push().set(comunidade.toJson());
    }
  }

  void _handleChange(Event event) {
    var oldMessage = _mensagensComunidade.singleWhere((entrada){
      return entrada.key == event.snapshot.key;
    });
    setState(() {
      _mensagensComunidade[_mensagensComunidade.indexOf(oldMessage)]
      = Comunidade.fromSnapshot(event.snapshot);
    });
  }
}
