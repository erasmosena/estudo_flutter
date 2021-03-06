import 'package:flutter/material.dart';
import 'package:lojavirtual/models/cart_model.dart';
import 'package:lojavirtual/models/user_model.dart';
import 'package:lojavirtual/screens/login_screen.dart';
import 'package:lojavirtual/screens/order_screen.dart';
import 'package:lojavirtual/tiles/cart_tile.dart';
import 'package:lojavirtual/widgets/cart_price.dart';
import 'package:lojavirtual/widgets/discount_card.dart';
import 'package:lojavirtual/widgets/ship_card.dart';
import 'package:scoped_model/scoped_model.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Carrinho"),
        actions: <Widget>[
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(right:8),
            child: ScopedModelDescendant<CartModel>(
              builder: (context, child, model){
                int p = model.products.length;
                return Text(
                  "${p??0} ${p==1?"ITEM":"ITENS"}",
                  style:TextStyle(fontSize: 17)
                );
              },
            ),
          )
        ],
      ),
      body: ScopedModelDescendant<CartModel>(
        builder: (context, child, model){
          var isLogged = UserModel.of(context).isLoggedIn();
          if( model.isLoading &&  isLogged){
            return Center(
              child: CircularProgressIndicator(),
            );
          }else if (!isLogged){
            return Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.remove_shopping_cart, size: 80, color: Theme.of(context).primaryColor,),
                  SizedBox(height: 16,),
                  Text(
                    "Faça o Login Para Adicionar Produtos",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,),
                    RaisedButton(
                      child: Text(
                        "Entrar",
                        style:TextStyle(
                          fontSize: 18
                        ),
                      ),
                      textColor: Colors.white,
                      color: Theme.of(context).primaryColor,
                      onPressed:(){
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context)=>LoginScreen()));
                      },
                    )

                ],
              ),
            );
          }else if(model.products == null || model.products.length ==0 ){
            return Center(
              child: Text(
                "Nenhum produto no carrinho!",
                style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
                ),
            );
          }else{
            return ListView(
              children: <Widget>[
                Column(
                  children:model.products.map((item){
                    var cartTile=  CartTile(item);
                    return cartTile;
                  }).toList(),
                  
                ),
                DiscountCard(),
                ShipCard(),
                CartPrice(()async{
                  String orderId = await model.finishOrder();
                  if( orderId != null){
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => OrderScreen(orderId))
                    );
                  }
                }),
              ],
            );
          }

        },
      ),
    ); 
  }
}