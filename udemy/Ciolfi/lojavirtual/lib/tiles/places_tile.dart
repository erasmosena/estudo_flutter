import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PlaceTileDoc extends StatelessWidget {
  final DocumentSnapshot place ;

  PlaceTileDoc(this.place);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Column(
        crossAxisAlignment :CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(
            height: 100,
            child: Image.network(
              place.data['image'],
              fit:BoxFit.cover
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  place.data['title'],
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17
                  ),
                ),
                Text(
                  place.data['address'],
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: <Widget>[
              FlatButton(
                child: Text("Ver no mapa"),
                textColor: Colors.blue,
                padding: EdgeInsets.zero,
                onPressed: (){
                  launch("https://www.google.com/maps/search/${place.data['lat']},${place.data['long']}");
                },
              ),
              FlatButton(
                child: Text("Ligar"),
                textColor: Colors.blue,
                padding: EdgeInsets.zero,
                onPressed: (){
                  launch("tel:${place.data['phone']}");
                },
              )
            ],
          )
        ],
      ),
      
    );
  }
}