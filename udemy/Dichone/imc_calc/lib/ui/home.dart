import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _idadeController = TextEditingController();
  final TextEditingController _alturaController = TextEditingController();
  final TextEditingController _pesoController = TextEditingController();
  double _indice = 2;
  String _resultado = "a";

    double calcularIMC(double peso, double altura) {
      return peso / (altura * altura);
    }

 
    /*    
    Baixo peso muito grave = abaixo de 16 kg/m²
Baixo peso grave = entre 16 e 16,99 kg/m²
Baixo peso = entre 17 e 18,49 kg/m²
Peso normal = entre 18,50 e 24,99 kg/m²
Sobrepeso = entre 25 e 29,99 kg/m²
Obesidade grau I = entre 30 e 34,99 kg/m²
Obesidade grau II = entre 35 e 39,99 kg/m²
Obesidade grau III (obesidade mórbida) = maior que 40 kg/m²
  */
    String avaliarIndice(double indice) {
      if( indice < 16) return "Baixo peso muito grave";
      else if( indice >= 16 && indice <= 16.99) return "Baixo peso grave";
      else if( indice >= 17 && indice <= 18.49) return "Baixo peso";
      else if( indice >= 18.5 && indice <= 24.99) return "Peso normal";
      else if( indice >= 25 && indice <= 29.99) return "Sobrepeso";
      else if( indice >= 30.0 && indice <= 34.99) return "Obesidade grau I";
      else if( indice >= 35.0 && indice <= 39.99) return "Obesidade grau II";
      else if( indice >= 40.0 ) return "Obesidade grau III (obesidade mórbida)";
      return "Não foi possível avaliar";
    }

    void _clickCalcular() {
      
        
        if (_alturaController.text.isEmpty) {
          final snackBar = SnackBar(content: Text("Preciso saber a sua altura"));
          Scaffold.of(context).showSnackBar(snackBar);
          return;
        }
        if (_pesoController.text.isEmpty) {
          final snackBar = SnackBar(content: Text("Preciso saber o seu peso"));
          Scaffold.of(context).showSnackBar(snackBar);
          return;
        }
        double indice = calcularIMC(double.parse(_pesoController.text),
              double.parse(_alturaController.text));
      setState(() {  
          _indice = indice;
          _resultado = avaliarIndice((indice));
        debugPrint(_indice.toString());
        debugPrint(_resultado);
      });
    }

  @override
  Widget build(BuildContext context) {   
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        centerTitle: true,
        title: Text("IMC"),
      ),
      body: Container(
          alignment: Alignment.topCenter,
          child: ListView(
            padding: const EdgeInsets.all(1.5),
            children: <Widget>[
              Image.asset(
                "assets/imc-logo.png",
                width: 75,
                height: 75,
              ),
              Container(

                color: Colors.grey.shade300,
                child: Column(
                  children: <Widget>[
                    TextField(
                      controller: _idadeController,
                      keyboardType: TextInputType.number,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                          labelText: "Idade",
                          hintText: "Exemplo: 32",
                          icon: Icon(Icons.person_outline)),
                    ),
                    TextField(
                      controller: _alturaController,
                      keyboardType: TextInputType.number,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                          labelText: "Altura(m)",
                          hintText: "Exemplo: 1.70",
                          icon: Icon(Icons.assessment)),
                    ),
                    TextField(
                      controller: _pesoController,
                      style: TextStyle(color: Colors.black),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: "Peso(Kg)",
                          hintText: "Exemplo: 100",
                          icon: Icon(Icons.dehaze)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: RaisedButton(
                          onPressed: _clickCalcular,
                          color: Colors.pinkAccent,
                          child: Text(
                            "Calcular",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5.0),
                child: Container(
                  alignment: Alignment.topCenter,
                  child: Text(
                    "$_indice",
                    style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 19.9),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5.0),
                child: Container(
                  alignment: Alignment.topCenter,
                  child: Text(
                    "$_resultado",
                    style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 19.9)
                  ),
                ),
              ),
            ],
          ),
        )
    );
  }
}
