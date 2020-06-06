import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:xlo/api/api_cep.dart';
import 'package:xlo/common/cep_field.dart';
import 'package:xlo/common/custom_drawer/custom_drawer.dart';
import 'package:xlo/helpers/formatField.dart';
import 'package:xlo/screens/create/widget/hide_phone_widget.dart';
import 'package:xlo/screens/create/widget/images_field.dart';

class CreateScreen extends StatefulWidget {
  @override
  _CreateScreenState createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Inserir Anúncio'),
      ),
      drawer: CustomDrawer(),
      body: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            ImagesField(
              onSaved: (images) {},
              initialValue: [],
            ),
            TextFormField(
              decoration: InputDecoration(
                  labelText: 'Título *',
                  labelStyle: TextStyle(
                      fontWeight: FontWeight.w800,
                      color: Colors.grey,
                      fontSize: 18),
                  contentPadding: const EdgeInsets.fromLTRB(16, 10, 12, 10)),
              validator: (text) {
                if (text.isEmpty) return 'Campo obrigatório';
                return null;
              },
              onSaved: (t) {},
            ),
            TextFormField(
              maxLines: null,
              decoration: InputDecoration(
                  labelText: 'Descrição *',
                  labelStyle: TextStyle(
                      fontWeight: FontWeight.w800,
                      color: Colors.grey,
                      fontSize: 18)),
              validator: (text) {
                if (text.trim().isEmpty) return 'Campo obrigatório';
                if (text.trim().length > 10) return 'Descrição muito curta';
                return null;
              },
              onSaved: (d) {},
            ),
            CepField(
              decoration: InputDecoration(
                labelText: 'Cep *',
                labelStyle: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: Colors.grey,
                    fontSize: 18),
                contentPadding: const EdgeInsets.fromLTRB(10, 10, 12, 10),
              ),
              onSaved: (a){
                print(a);
              },
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Preço *',
                labelStyle: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: Colors.grey,
                    fontSize: 18),
                contentPadding: const EdgeInsets.fromLTRB(10, 10, 12, 10),
              ),
              keyboardType: const TextInputType.numberWithOptions(
                  decimal: true, signed: false),
              inputFormatters: [
                WhitelistingTextInputFormatter.digitsOnly,
                RealInputFormatter(centavos: true),
              ],
              validator: (text) {
                
                if (text.trim().isEmpty) return 'Campo obrigatório';
                if (BigInt.parse(getSanitizedText(text)) == null)
                  return 'Utilize valores válidos';
                return null;
              },
              onSaved: (price){

              },
            ),
  
            HidePhoneWidget(
              onSaved: (h){

              }, initialValue: false,
            ),
            Container(
                child: RaisedButton(
              color: Colors.pink,
              child: Text('Enviar',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 18)),
              onPressed: () {
                if (_formKey.currentState.validate()) {

                }
              },
            ))
          ],
        ),
      ),
    );
  }
}
