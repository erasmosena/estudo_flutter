import 'package:flutter/material.dart';
import 'package:lojavirtual/models/product_model.dart';
import 'package:lojavirtual/screens/product_screen.dart';

class ProductGridTile extends StatelessWidget {
  final Product product;
  ProductGridTile( this.product);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context)=>ProductScreen(product))
        );
      },
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
             AspectRatio(
               aspectRatio: 0.8,
               child: Image.network(
                 product.images[0],
                 fit: BoxFit.cover,
               ),
             ),
             Expanded(
               child: Container(
                 padding: EdgeInsets.all(8),
                 child: Column(
                   children: <Widget>[
                     Text(
                       product.title,
                       style: TextStyle(
                         fontWeight: FontWeight.w500
                       ),
                      ),
                     Text(
                       "R\$ ${product.price.toStringAsFixed(2)}",
                       style: TextStyle(
                         color:Theme.of(context).primaryColor,
                         fontSize: 17,
                         fontWeight: FontWeight.bold

                       ),
                       )
                   ],
                 ),
               ),
             )
          ],
        ),
      ),
    );
  }
}