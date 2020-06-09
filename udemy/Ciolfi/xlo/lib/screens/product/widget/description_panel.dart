import 'package:flutter/material.dart';
import 'package:xlo/models/anuncio_view.dart';

class DescriptionPanel extends StatefulWidget {
  AnuncioView anuncio;

  DescriptionPanel(this.anuncio);

  @override
  _DescriptionPanelState createState() => _DescriptionPanelState();
}

class _DescriptionPanelState extends State<DescriptionPanel> {
  AnuncioView get anuncio => widget.anuncio;

  bool open = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 18),
          child: Text(
            'Descrição',
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 18),
          child: Text(
            anuncio.description,
            maxLines: open ? 10 : 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
          ),
        ),
        open || anuncio.description.length < 100
            ? const SizedBox(height: 18)
            : Align(
                alignment: Alignment.centerLeft,
                child: FlatButton(
                  padding: EdgeInsets.zero,
                  child: Text('Ver descrição completa',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Colors.pink)),
                  onPressed: () {
                    setState(() {
                      open = true;
                    });
                  },
                ),
              )
      ],
    );
  }
}
