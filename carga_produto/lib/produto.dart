
class Produto {
  final int id;
  final String descricao;

  Produto({this.id, this.descricao});

  // factory Produto.fromJson(Map<String, dynamic> json) {
  //   return Produto(
  //     id: json['id'],
  //     descricao: json['descricao'],
  //   );
  // }
  //outra notação 
  Produto.fromJson(Map json)
      : id = json['id'],
        descricao = json['descricao'];

  Map toJson() {
    return {'id': id, 'descricao': descricao};
  }

}