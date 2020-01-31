import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtual/models/cart_model.dart';

class DiscountCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ExpansionTile(
        title: Text(
          "Cupom de Disconto",
          textAlign: TextAlign.start,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.grey[700]
          ),
          ),
          leading: Icon(
            Icons.card_giftcard
          ),
          trailing: Icon(Icons.add),
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8),
              child: TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Digite seu cupom"
                ),
                initialValue: CartModel.of(context).coupomCode??"",
                onFieldSubmitted: (text){
                  Firestore.instance.collection("coupons").document(text).get().then((snap){
                    if(snap.data != null ){
                      CartModel.of(context).setCoupom(text, snap.data['percent']);
                      Scaffold.of(context).showSnackBar(
                        SnackBar(content: Text("Descono de ${snap.data['percent']}% aplicado."),
                        backgroundColor: Theme.of(context).primaryColor,
                        )
                      );
                    }else{
                      CartModel.of(context).setCoupom(null, 0 );
                      Scaffold.of(context).showSnackBar(
                        SnackBar(content: Text("Cupom não existe."),
                        backgroundColor: Theme.of(context).errorColor,
                        )
                      );
                    }
                  });
                },
              ),
            )
          ],
      ),
    );
  }
}