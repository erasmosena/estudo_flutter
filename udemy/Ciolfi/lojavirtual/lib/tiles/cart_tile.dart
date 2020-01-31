import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtual/helpers/cart_product.dart';
import 'package:lojavirtual/helpers/product_model.dart';
import 'package:lojavirtual/models/cart_model.dart';

class CartTile extends StatelessWidget {
  final CartProduct cartProduct;
  CartTile(this.cartProduct);

  

  @override
  Widget build(BuildContext context) {
    CartModel.of(context).updatePrices();
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: cartProduct.produto == null
          ? FutureBuilder<DocumentSnapshot>(
              future: Firestore.instance
                  .collection("products")
                  .document(cartProduct.category)
                  .collection("items")
                  .document(cartProduct.idProduto)
                  .get(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  cartProduct.produto = Product.fromDocument(snapshot.data);
                  return _buildContent(context);
                } else {
                  return Container(
                    height: 70,
                    child: CircularProgressIndicator(),
                    alignment: Alignment.center,
                  );
                }
              })
          : _buildContent(context),
    );
  }
  Widget _buildContent(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
            padding: const EdgeInsets.all(8),
            width: 120,
            child: Image.network(
              cartProduct.produto.images[0],
              fit: BoxFit.cover,
            )),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  cartProduct.produto.title,
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
                ),
                Text(
                  "Tamanho: ${cartProduct.tamanho}",
                  style: TextStyle(fontWeight: FontWeight.w300),
                ),
                Text(
                  "R\$ ${cartProduct.produto.price.toStringAsFixed(2)}",
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: cartProduct.qtde > 1 ?() {
                        CartModel.of(context).decProduct(cartProduct);
                      }: null,
                      color: Theme.of(context).primaryColor,
                    ),
                    Text(cartProduct.qtde.toString()),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        CartModel.of(context).incProduct(cartProduct);
                      },
                      color: Theme.of(context).primaryColor,
                    ),
                    FlatButton(
                      child: Text("Remover"),
                      textColor: Colors.grey[500],
                      onPressed: () {
                        CartModel.of(context).removeCartItem(cartProduct);
                      },
                      
                    )
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
