import 'package:flutter/material.dart';
import 'package:xlo/models/anuncio_view.dart';

class BottomBar extends StatelessWidget {
  final AnuncioView anuncio;

  BottomBar(this.anuncio);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 16,
      right: 16,
      bottom: 0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            height: 38,
            margin: const EdgeInsets.symmetric(horizontal: 26),
            decoration: BoxDecoration(
                color: Colors.pink,
                borderRadius: const BorderRadius.all(Radius.circular(19))),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 25,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          border:
                              Border(right: BorderSide(color: Colors.black45))),
                      child: Text('Ligar',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 15)),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {},
                    child: Text('Chat',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 15)),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            alignment: Alignment.center,
            height: 38,
            decoration: BoxDecoration(
                color: const Color.fromRGBO(249, 249, 249, 1),
                border: Border(top: BorderSide(color: Colors.grey[400]))),
            child: Text(
              'Anunciante(anunciante)',
              style: TextStyle(fontWeight: FontWeight.w300),
            ),
          )
        ],
      ),
    );
  }
}
