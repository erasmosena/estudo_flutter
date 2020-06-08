import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:xlo/blocs/create_bloc.dart';
import 'package:xlo/blocs/drawer_bloc.dart';
import 'package:xlo/blocs/home_bloc.dart';
import 'package:xlo/common/cep_field.dart';
import 'package:xlo/common/custom_drawer/custom_drawer.dart';
import 'package:xlo/helpers/formatField.dart';
import 'package:xlo/models/anuncio_view.dart';
import 'package:xlo/screens/create/widget/hide_phone_widget.dart';
import 'package:xlo/screens/create/widget/images_field.dart';

class CreateScreen extends StatefulWidget {
  @override
  _CreateScreenState createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  AnuncioView add = AnuncioView();

  CreateBloc _createBloc;

  @override
  void initState() {
    super.initState();
    _createBloc = CreateBloc();
  }

  @override
  void dispose() {
    _createBloc?.dispose();
    super.dispose();
  }

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
        child: StreamBuilder<CreateState>(
            stream: _createBloc.outState,
            builder: (context, snapshot) {
              if (snapshot.data == CreateState.LOADING)
                return Center(
                    child: Container(
                        width: 300,
                        height: 300,
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.pink),
                              strokeWidth: 5,
                        )));
              return ListView(
                children: <Widget>[
                  ImagesField(
                    onSaved: (images) {
                      add.images = images;
                    },
                    initialValue: [],
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Título *',
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.w800,
                            color: Colors.grey,
                            fontSize: 18),
                        contentPadding:
                            const EdgeInsets.fromLTRB(16, 10, 12, 10)),
                    validator: (text) {
                      if (text.isEmpty) return 'Campo obrigatório';
                      return null;
                    },
                    onSaved: (t) {
                      add.title = t;
                    },
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
                      if (text.trim().length < 10)
                        return 'Descrição muito curta';
                      return null;
                    },
                    onSaved: (d) {
                      add.description = d;
                    },
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
                    onSaved: (a) {
                      add.address = a;
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
                    onSaved: (p) {
                      add.price = int.parse(getSanitizedText(p)) / 100;
                    },
                  ),
                  HidePhoneWidget(
                    onSaved: (h) {
                      add.hidePhone = h;
                    },
                    initialValue: false,
                  ),
                  Container(
                      child: RaisedButton(
                    color: Colors.pink,
                    child: Text('Enviar',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 18)),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();
                        //remover 
                        Provider.of<HomeBloc>(context, listen:false).adicionarAnuncio(add);
                        //endremover

                        final bool success = await _createBloc.saveAdd(add);
                        if (success) {                          
                          Provider.of<DrawerBloc>(context, listen:false).setPage(0);
                        }
                      }
                    },
                  ))
                ],
              );
            }),
      ),
    );
  }
}
