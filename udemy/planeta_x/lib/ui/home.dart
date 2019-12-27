import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final TextEditingController _pesoController = TextEditingController();
  int radioValor = 1;
  String _nomePlaneta = "";
  double _valorResultante = 0 ;

  void radioChange(int value) {
    setState(() {
      radioValor = value;
      switch (radioValor) {
        case 0:
          _nomePlaneta = "Planeta Plutão";
          _valorResultante = calcularPeso(_pesoController.text,0.06);
          break;
        case 1:
          _nomePlaneta = "Planeta Marte";
          _valorResultante = calcularPeso(_pesoController.text,0.38);
          break;
        case 2:
          _nomePlaneta = "Planeta Venus";
          _valorResultante = calcularPeso(_pesoController.text,0.91);
          break;
        default:
          debugPrint("asdf");
      }
    });
  }

  double calcularPeso(String peso, double gravidade) {
    if (peso.isNotEmpty && int.parse(peso) >  0) {
      return int.parse(peso) * gravidade;
    }else{
      debugPrint("peso não pode ser 0.");
      return 180 * 0.38;
    }
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Planeta X"),
        backgroundColor: Colors.black38,
      ),
      backgroundColor: Colors.blueGrey,
      body: Container(
        alignment: Alignment.topCenter,
        child: ListView(
          padding: const EdgeInsets.all(1.5),
          children: <Widget>[
            Image.asset(
              'assets/planet.png',
              height: 133.0,
              width: 200.0,
            ),
            Container(
              margin: const EdgeInsets.all(3.0),
              alignment: Alignment.center,
              child: Column(
                children: <Widget>[
                  TextField(
                    controller: _pesoController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "O Seu Peso na Terra",
                        hintText: "Kg",
                        icon: Icon(Icons.person_outline)),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Radio<int>(
                        activeColor: Colors.brown,
                        value: 0,
                        groupValue: radioValor,
                        onChanged: radioChange,
                      ),
                      Text(
                        "Plutão",
                        style: TextStyle(color: Colors.white),
                      ),
                      Radio<int>(
                        activeColor: Colors.red,
                        value: 1,
                        groupValue: radioValor,
                        onChanged: radioChange,
                      ),
                      Text(
                        "Marte",
                        style: TextStyle(color: Colors.white),
                      ),
                      Radio<int>(
                        activeColor: Colors.orangeAccent,
                        value: 2,
                        groupValue: radioValor,
                        onChanged: radioChange,
                      ),
                      Text(
                        "Vênus",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  Text(
                    _pesoController.text.isEmpty ? "Insira o seu peso":
                    "O meu peso no planeta $_nomePlaneta é $_valorResultante",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 19.4,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
