import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:rxdart/rxdart.dart';

class ProdutoBloc extends BlocBase {
  final _dataController = BehaviorSubject<Map>();
  final _loadingController = BehaviorSubject<bool>();
  final _createdController = BehaviorSubject<bool>();
  Stream<Map> get outData => _dataController.stream;
  Stream<bool> get outLoading => _loadingController.stream;
  Stream<bool> get outCreated => _createdController.stream;

  String CategoryId;
  DocumentSnapshot produto;

  Map<String, dynamic> unsavedData;

  @override
  void dispose() {
    _createdController.close();
    _dataController.close();
    _loadingController.close();
    super.dispose();
  }

  ProdutoBloc(this.CategoryId, this.produto) {
    if (produto != null) {
      unsavedData = Map.of(produto.data);
      unsavedData["images"] = List.of(produto.data["images"]);
      unsavedData["sizes"] = List.of(produto.data["sizes"]);
      _createdController.add(true);
    } else {
      unsavedData = {
        "title": null,
        "description": null,
        "price": null,
        "images": [],
        "sizes": []
      };
      _createdController.add(false);
    }
    _dataController.add(unsavedData);
  }

  void toUnsavedList(String prop, List lista) {
    unsavedData[prop] = lista;
  }

  void toUnsavedNumber(String prop, String text) {
    unsavedData[prop] = double.tryParse(text);
  }

  void toUnsavedText(String prop, String text) {
    unsavedData[prop] = text;
  }

  Future<bool> saveProduto() async {
    _loadingController.add(true);
    try {
      if (produto != null) {
        await _uploadingImages(produto.documentID);
        await produto.reference.updateData(unsavedData);
      } else {
        DocumentReference dr = await Firestore.instance
            .collection("products")
            .document(CategoryId)
            .collection("items")
            .add(Map<String,dynamic>.from(unsavedData)..remove("images"));
        await _uploadingImages(dr.documentID);
        await dr.updateData(unsavedData);
      }
      _loadingController.add(false);
      _createdController.add(true);
      return true;
    } catch (error) {
      print(error.toString());
      _loadingController.add(false);
      return false;
    }  
  }

  Future _uploadingImages(String IdProduto) async {
    for (int i = 0; i < unsavedData["images"].length; i++) {
      var data = unsavedData["images"][i];
      if (data is String) continue;
      StorageUploadTask uploadTask = FirebaseStorage.instance
          .ref()
          .child(CategoryId)
          .child(IdProduto)
          .child(DateTime.now().millisecondsSinceEpoch.toString())
          .putFile(data);
      StorageTaskSnapshot s = await uploadTask.onComplete;
      String downloadUrl = await s.ref.getDownloadURL();
      unsavedData["images"][i] = downloadUrl;
    }
  }

  void deleteProduto() {
   produto.reference.delete(); 
  }
}
