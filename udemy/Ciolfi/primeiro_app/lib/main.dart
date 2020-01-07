import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      title: "Titulo",
      theme: ,
      home: Home()
    )
  );
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}



class _HomeState extends State<Home> {

  int _pessoas = 0 ;
  String _infoText = "";
  void _peopleChange(int delta){
  setState(() {
    _pessoas += delta;
    if( _pessoas < 0 ){
      _infoText = "Mundo invertido";
    }else if(_pessoas <= 10) {
      _infoText = "pode entrar";
    }else{
      _infoText = "Lotado";
    }
  });
}

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: <Widget>[
          Image.asset(
            "images/restaurant.jpg",
            fit: BoxFit.cover,
            height: 1000,

          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Pessoas: $_pessoas',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: FlatButton(
                      onPressed: () {
                        _peopleChange(1);
                      },
                      child: Text(
                        "+1",
                        style: TextStyle(fontSize: 40, color: Colors.white),
                      ),
                    ),
                  ),
                  
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: FlatButton(
                        onPressed: () {
                          _peopleChange(-1);
                        },
                        child: Text(
                          "-1",
                          style: TextStyle(fontSize: 40, color: Colors.white),
                        )),
                  )
                ],
              ),
              Text(
                '$_infoText',
                style:
                    TextStyle(color: Colors.white, fontStyle: FontStyle.italic),
              )
            ],
          ),
        ],
      );
  }
}