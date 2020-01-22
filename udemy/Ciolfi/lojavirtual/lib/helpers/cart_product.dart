import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lojavirtual/helpers/product_model.dart';

class CartProduct {
  String id;
  String category;
  String idProduto;
  int qtde;
  String tamanho;

  Product produto;

  CartProduct();
  CartProduct.fromDocument(DocumentSnapshot documentSnapshot) {
    id = documentSnapshot.documentID;
    category = documentSnapshot.data["category"];
    idProduto = documentSnapshot.data["idProduto"];
    qtde = documentSnapshot.data["qtde"];
    tamanho = documentSnapshot.data["tamanho"];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> mapa = new Map();
    mapa["category"] = category;
    mapa["idProduto"] = idProduto;
    mapa["qtde"] = qtde;
    mapa["tamanho"] = tamanho;
    //mapa["produto"] = produto.toMap();
    return mapa;
  }
  
}
