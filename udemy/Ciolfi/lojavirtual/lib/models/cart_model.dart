import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtual/helpers/cart_product.dart';
import 'package:lojavirtual/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class CartModel extends Model {
  List<CartProduct> products = [];
  UserModel user;
  
  CartModel(this.user);

  static CartModel of(BuildContext context)
  {
    return ScopedModel.of<CartModel>(context);
  }

  void addCartItem(CartProduct cartProduct){
    products.add(cartProduct);
    Firestore.instance.collection("user").document(user.firebaseUser.uid)
    .collection("cart").add(cartProduct.toMap()).then((doc){
      cartProduct.id = doc.documentID;
    });
    notifyListeners();
  }
  void removeCartItem(CartProduct cartProduct){
    Firestore.instance.collection("user").document(user.firebaseUser.uid)
    .collection("cart").document(cartProduct.id).delete();
    products.remove(cartProduct);
    notifyListeners();
  }
}