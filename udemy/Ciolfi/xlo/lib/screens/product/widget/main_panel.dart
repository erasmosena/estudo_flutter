import 'package:flutter/material.dart';
import 'package:xlo/helpers/formatField.dart';
import 'package:xlo/models/anuncio_view.dart';

class MainPanel extends StatelessWidget {
  final AnuncioView anuncio;

  const MainPanel(this.anuncio);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 24, bottom: 14),
          child: Text(
            'R\$${numToString(anuncio.price)}',
            style: TextStyle(
                fontSize: 34,
                letterSpacing: 2,
                fontWeight: FontWeight.w300,
                color: Colors.grey[800]),
          ),
        ),
        Text(
          anuncio.title,
          style: TextStyle(
              fontWeight: FontWeight.w400, letterSpacing: 1, fontSize: 18),
        ),
        Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 18),
            child: Text('Publicado em ${dataToString(anuncio.dateCreated)}',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey[600])))
      ],
    );
  }
}
