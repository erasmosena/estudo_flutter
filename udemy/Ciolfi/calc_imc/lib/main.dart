import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      primarySwatch: Colors.green,
    ),
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _infoText = "Informe seus dados";
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  void _resetField(){
    setState(() {
      weightController.text = "";
      heightController.text = "";
      _infoText = "Informe seus dados";  
      _formKey = GlobalKey<FormState>();
    });
      
    
  }

  void _calculate(){
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text)/100;
      double imc = weight / (height * height);
      print(imc);
      if( imc < 18.6 ){
        _infoText = "Abaixo do peso(${imc.toStringAsPrecision(4)}))";
      }else if( imc >= 18.6 && imc < 24.9 ){
        _infoText = "Peso ideal(${imc.toStringAsPrecision(4)}))";
      }else if( imc >= 24.9 && imc < 29.9){
        _infoText = "Levemente Acima do Peso(${imc.toStringAsPrecision(4)}))";
      }else if( imc >= 29.6 && imc < 34.9){
        _infoText = "Obesidade Grau I(${imc.toStringAsPrecision(4)}))";
      }else if( imc >= 34.6 && imc < 39.9){
        _infoText = "Obesidade Grau II(${imc.toStringAsPrecision(4)}))";
      }else if( imc >= 40 ){
        _infoText = "Obesidade Grau III(${imc.toStringAsPrecision(4)}))";
      }
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Calculadora de IMC'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed:_resetField,
            )
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(10,0,10,0),
          child: Form(
            key: _formKey,
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(
                Icons.person_outline,
                size: 120,
                color: Colors.green,
              ),
              TextFormField(
                validator: (value){if(value.isEmpty){
                  return "Insira Seu Peso ";
                }},
                keyboardType: TextInputType.number,
                controller: weightController,
                decoration: InputDecoration(
                  labelText: "Peso (Kg)",
                  labelStyle: TextStyle(color: Colors.green),
                ),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25),
              ),
              TextFormField(
                validator: (value){if(value.isEmpty){
                  return "Insira Sua Altura ";
                }},
                keyboardType: TextInputType.number,
                controller: heightController,
                decoration: InputDecoration(
                  labelText: "Altura (cm)",
                  labelStyle: TextStyle(color: Colors.green),
                ),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25),
              ),
              Padding(
                padding: const EdgeInsets.only(top:10.0, bottom: 10),
                child: Container(
                  height: 50,
                  child: RaisedButton(
                    onPressed: (){
                      if(_formKey.currentState.validate()){
                        _calculate();
                      }
                    },
                    child: Text(
                      "Calcular",
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                    color: Colors.green,
                  ),
                ),
              ),
              Text(
                "$_infoText",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25),
              )
            ],
          ),
          )
        ));
  }
}
