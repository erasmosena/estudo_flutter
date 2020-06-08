import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:xlo/models/anuncio_view.dart';

class ProductTile extends StatelessWidget {
  final AnuncioView anuncio;

  ProductTile({this.anuncio});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 135,
        margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 1),
        child: Card(
          child: Row(
            children: <Widget>[
              SizedBox(
                height: 135,
                width: 127,
                child: Image.file(anuncio.images[0], fit: BoxFit.cover),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        anuncio.title,
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        'R\$${numToString(anuncio.price)}',
                        style: TextStyle(
                            fontSize: 19, fontWeight: FontWeight.w700),
                      ),
                      Text(
                          '${anuncio.address.localidade}, ${anuncio.address.uf}',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w300))
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  String numToString(num number) {
    return NumberFormat('###,##0.00', 'pt-br')
        .format(double.parse(number.toStringAsFixed(2)));
  }
}