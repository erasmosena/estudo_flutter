import 'package:conversor_moeda/main.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController realController = TextEditingController();
  final TextEditingController dolarController = TextEditingController();
  final TextEditingController euroController = TextEditingController();
  double dolar = 0;
  double euro = 0;

  void _realChanged(String text){
    if(text.isEmpty) {
      _clearAll();
      return;
    }
    double real = double.parse(text);
    dolarController.text = (real/dolar).toStringAsFixed(2);
    euroController.text = (real/euro).toStringAsFixed(2);
  }

  void _dolarChanged(String text){
    if(text.isEmpty) {
      _clearAll();
      return;
    }
    double dolar = double.parse(text);
    realController.text = (dolar * this.dolar).toStringAsFixed(2);
    euroController.text = (dolar* this.dolar/euro).toStringAsFixed(2);
  }

  void _euroChanged(String text){
    if(text.isEmpty) {
      _clearAll();
      return;
    }
    double euro = double.parse(text);
    realController.text = (euro * this.euro).toStringAsFixed(2);
    dolarController.text = (euro* this.euro/dolar).toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("\$ Conversor \$"),
        backgroundColor: Colors.amber,
        centerTitle: true,
      ),
      body: FutureBuilder<Map>(
        future: getData(),
        builder: (_, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(
                child: Text(
                  "Carregando",
                  style: TextStyle(color: Colors.amber, fontSize: 25),
                ),
              );
            default:
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    "Erro ao carregar dados :|",
                    style: TextStyle(color: Colors.amber, fontSize: 25),
                    textAlign: TextAlign.center,
                  ),
                );
              } else {
                dolar = snapshot.data["results"]["currencies"]["USD"]["buy"];
                euro = snapshot.data["results"]["currencies"]["EUR"]["buy"];
                return SingleChildScrollView(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Icon(
                        Icons.monetization_on,
                        size: 150,
                        color: Colors.amber,
                      ),
                      buildTextField("Reais", "R\$", realController, _realChanged),
                      Divider(),
                      buildTextField("Dolares", "US\$",dolarController,_dolarChanged),
                      Divider(),
                      buildTextField("Euros", "EUR", euroController, _euroChanged)
                    ],
                  ),
                );
              }
          }
        },
      ),
    );
  }
  void _clearAll(){
    realController.text = "";
    dolarController.text = "";
    euroController.text = "";
  }
}

Widget buildTextField(String label, String prefix, TextEditingController controller, Function f ){
  final TextStyle style = TextStyle(
        color: Colors.amber,
        fontSize: 25
      );
  return TextField(
    keyboardType: TextInputType.numberWithOptions(decimal: true),
    controller: controller,
    onChanged: f ,
    decoration: InputDecoration(
      labelText: "$label",
      labelStyle: style,
      enabledBorder: const OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.amber, ),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.white, ),
      ),
      
      prefixText: "$prefix  ",
      prefixStyle: style,
    ),
    style: TextStyle(color: Colors.amber, fontSize: 25),
  );
}

