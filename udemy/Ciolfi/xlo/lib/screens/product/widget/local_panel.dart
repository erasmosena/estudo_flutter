import 'package:flutter/material.dart';
import 'package:xlo/models/anuncio_view.dart';

class LocalPanel extends StatelessWidget {
  AnuncioView anuncio;

  LocalPanel(this.anuncio);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 18, bottom: 18),
          child: Text('Localização',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('CEP'),
                  SizedBox(
                    height: 12,
                  ),
                  Text('Município'),
                  SizedBox(
                    height: 12,
                  ),
                  Text('Bairro'),
                  SizedBox(
                    height: 12,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('${anuncio.address.cep}'),
                    SizedBox(
                      height: 12,
                    ),
                    Text('${anuncio.address.localidade}'),
                    SizedBox(
                      height: 12,
                    ),
                    Text('${anuncio.address.uf}'),
                    SizedBox(
                      height: 12,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
