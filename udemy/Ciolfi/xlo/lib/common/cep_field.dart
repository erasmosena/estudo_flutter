import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:xlo/blocs/cep_bloc.dart';
import 'package:xlo/models/address.dart';

class CepField extends StatefulWidget {
  final InputDecoration decoration;
  final FormFieldSetter<Address> onSaved ; 
  CepField({this.decoration, this.onSaved});

  @override
  _CepFieldState createState() => _CepFieldState();
}

class _CepFieldState extends State<CepField> {

  InputDecoration get decoration => widget.decoration;
  FormFieldSetter<Address> get onSaved => widget.onSaved;

  CepBloc _cepBloc;

  @override
  void initState() { 
    super.initState();
    _cepBloc = CepBloc();
  }

  @override
  void dispose(){
    _cepBloc?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<CepBlocState>(
      stream: _cepBloc.outCep,
      initialData: CepBlocState(cepFieldState: CepFieldState.INITIALIZING),
      builder: (context, snapshot) {
        if( snapshot.data.cepFieldState == CepFieldState.INITIALIZING)
          return Container();
        return Column(
          children: <Widget>[
            TextFormField(
              initialValue: snapshot.data.cep,
              decoration: decoration,
              keyboardType: TextInputType.number,
              inputFormatters: [
                WhitelistingTextInputFormatter.digitsOnly,
                CepInputFormatter(),
              ] ,
              onSaved: (c){
                onSaved(snapshot.data.address);
              },
              onChanged: _cepBloc.onChanged,
              validator: (c){
                switch (snapshot.data.cepFieldState) {
                  case CepFieldState.INITIALIZING:
                  case CepFieldState.INCOMPLETE:
                  case CepFieldState.INVALID:
                    return 'Campo obrigatório';
                  case CepFieldState.VALID:
                  default:
                    return null;   
                }
              },
            ),
            buildInformation(snapshot.data)
          ],
        );
      }
    );
  }
  Widget buildInformation( CepBlocState blocState){
    switch (blocState.cepFieldState) {
      case CepFieldState.INITIALIZING:
      case CepFieldState.INCOMPLETE:
        return Container();
        break;
      case CepFieldState.INVALID:
        return Container(
          height: 50,
          padding: const EdgeInsets.all(8),
          alignment: Alignment.center,
          color: Colors.red.withAlpha(100),
          child:Text('CEP inválido',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color:Colors.red
          ),
          )
        );
      break;
      case CepFieldState.VALID:
        final _address = blocState.address;
        return Container(
          height: 50,
          padding: const EdgeInsets.all(8),
          alignment: Alignment.center,
          color: Colors.pink,
          child:Text('Localização: ${_address.toString()}',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color:Colors.white
          ),
          )
        );
        break;
      default:
    }
     
  }
} 