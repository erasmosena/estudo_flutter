import 'package:flutter/material.dart';
import 'package:lojavirtual/models/product_model.dart';
import 'package:lojavirtual/screens/product_screen.dart';

class ProductListTile extends StatelessWidget {
  final Product product;
  ProductListTile(this.product);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context)=>ProductScreen(product))
        );
      },
      child: Row(
        children: <Widget>[
          Flexible(
            flex: 1,
            child: Image.network(
              product.images[0],
              fit: BoxFit.cover,
              height: 250,
            ),
          ),
          Flexible(
            flex: 1,
            child: Container(
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    product.title,
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "R\$ ${product.price.toStringAsFixed(2)}",
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 17,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
