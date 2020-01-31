import 'package:flutter/material.dart';
import 'package:lojavirtual/models/cart_model.dart';
import 'package:scoped_model/scoped_model.dart';

class CartPrice extends StatelessWidget {
  
  final Function buy;

  CartPrice(this.buy);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ScopedModelDescendant<CartModel>(
        builder: (context, child, model) {
          double price = model.getProductsPrice();
          double discount = model.getDiscout();
          double shipPrice = model.getShipPrice();
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                "Resumo do pedido",
                textAlign: TextAlign.start,
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[Text("SubTotal"), Text("R\$ ${price.toStringAsFixed(2)}")],
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[Text("Desconto"), Text("R\$ ${discount.toStringAsFixed(2)}")],
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[Text("Entrega"), Text("R\$ ${shipPrice.toStringAsFixed(2)}")],
              ),
              Divider(),
              SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Total",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "R\$ ${(price - discount + shipPrice).toStringAsFixed(2) }",
                    style: TextStyle(fontSize: 16,color: Theme.of(context).primaryColor),
                  )
                ],
              ),
              SizedBox(
                height: 12,
              ),
              RaisedButton(
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                onPressed: buy,
                child: Text("Finalizar Pedido"),
              )
            ],
          );
        },
      ),
    );
  }
}
