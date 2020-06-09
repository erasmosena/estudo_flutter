import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:xlo/models/anuncio_view.dart';
import 'package:xlo/screens/product/widget/description_panel.dart';
import 'package:xlo/screens/product/widget/local_panel.dart';
import 'package:xlo/screens/product/widget/main_panel.dart';
import 'package:xlo/screens/product/widget/user_panel.dart';
import 'package:xlo/screens/product/widget/bottom_bar.dart';

class ProductScreen extends StatelessWidget {

  final AnuncioView anuncioView;

  ProductScreen(this.anuncioView);


  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      title: const Text('Anúncio'),
      elevation: 0,
    ),
    body: Stack(
      children: <Widget>[
        ListView(
          children: <Widget>[
            Container(
              height: 200,
              child: Carousel(
                images: anuncioView.images.map((f){
                  return FileImage(f);
                }).toList(),
                dotSize: 4,
                dotSpacing: 15,
                dotBgColor: Colors.transparent,
                dotColor: Colors.pink,
                autoplay: false,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  MainPanel(anuncioView),
                  Divider(),
                  DescriptionPanel(anuncioView),
                  Divider(),
                  LocalPanel(anuncioView),
                  Divider(),
                  UserPanel(anuncioView),              
                  SizedBox(height: 120,),
                ],
              ),
            )
          ],
        ),
        BottomBar(anuncioView),
      ],
    ),
    );
  }
}