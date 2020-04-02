import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';

class ProdutoBloc extends BlocBase {
  final _dataController = BehaviorSubject<Map>();
  Stream<Map> get outData => _dataController.stream;

  String CategoryId;
  DocumentSnapshot produto;

  Map<String, dynamic> unsavedData;

  ProdutoBloc(this.CategoryId, this.produto) {
    if (produto != null) {
      unsavedData = Map.of(produto.data);
      unsavedData["images"] = List.of(produto.data["images"]);
      unsavedData["sizes"] = List.of(produto.data["sizes"]);
    } else {
      unsavedData = {
        "title": null,
        "description": null, 
        "price": null,
        "images":[],
        "sizes":[]
      };
    }
    _dataController.add(unsavedData);
  }

  @override
  void dispose() {
    _dataController.close();
    super.dispose();
  }
}
