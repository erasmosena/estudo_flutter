import 'package:flutter/material.dart';

class Cadastro extends StatefulWidget {
  @override
  _CadastroState createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {

  final TextEditingController _usuarioController = TextEditingController();
  final TextEditingController _senhaController= TextEditingController();
  String _bemvindo;
  void _entrar(){
    setState(() {
      if( _usuarioController.text.isNotEmpty &&
        _senhaController.text.isNotEmpty){
          _bemvindo = _usuarioController.text;
      }
    });
  }

  void _cancelar(){
    setState(() {
      _usuarioController.clear();
      _senhaController.clear();  
      _bemvindo = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastro."),
        backgroundColor: Colors.deepOrangeAccent,
      ),
      backgroundColor: Colors.orangeAccent,
      body: Container(
        alignment: Alignment.center,
        child: ListView(
          children: <Widget>[
            Image.asset("assets/face.png",width: 90.0,height: 90.0,color: Colors.white),
            Container(
              width: double.infinity,
              color: Colors.white24,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _usuarioController, 
                      decoration: InputDecoration(
                        hintText: 'Nome',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4.5)
                        ),
                        icon: Icon(Icons.person)
                    ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _senhaController,
                      obscureText: true, 
                      decoration: InputDecoration(
                        hintText: 'Senha',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4.5)
                        ),
                        icon: Icon(Icons.visibility_off)
                    ),
                    ),
                  ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          child: RaisedButton(
                            onPressed: () => _entrar() ,
                            color: Colors.white,
                            child: Text(
                              "Entrar",
                              style: TextStyle(
                                color: Colors.blueAccent,
                                fontSize: 16.9
                              ),
                            ),
                          ),
                        ),
                        Container(
                          child: RaisedButton(
                            onPressed: () => _cancelar() ,
                            color: Colors.white,
                            child: Text(
                              "Cancelar",
                              style: TextStyle(
                                color: Colors.blueAccent,
                                fontSize: 16.9
                              ),
                            ),
                          ),
                        )

                      ],
                  ),
                  )
                  
                ]
                ),
             ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row( 
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("$_bemvindo",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.9,
                      fontWeight: FontWeight.w400
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
