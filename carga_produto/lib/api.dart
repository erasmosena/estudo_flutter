import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:carga_produto/produto.dart';

const baseUrl = "http://192.168.0.227:3000/";

class API {
  static Future getProdutos() {
    var url = baseUrl + "produtos/";
    return http.get(url);
  }

  static Future<Produto> getProduto(int id) async {
    final response = await http.get('http://192.168.0.227:3000/produtos/$id');

    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON.
      return Produto.fromJson(json.decode(response.body));
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load post');
    }
  }
}
