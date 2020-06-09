import 'package:flutter/material.dart';
import 'package:xlo/helpers/formatField.dart';
import 'package:xlo/models/anuncio_view.dart';

class UserPanel extends StatelessWidget {
  AnuncioView anuncio;

  UserPanel(this.anuncio);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top:18, bottom:18),
          child: Text('Anunciante',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          color: Colors.grey[200],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Nome do anunciante',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'No XLO desde ${dataToString(DateTime.now())}',
                style: TextStyle(color: Colors.grey),
              )
            ],
          ),
        )
      ],
    );
  }
}
