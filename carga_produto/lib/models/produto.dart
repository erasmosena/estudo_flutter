
class Produto {
  final int id;
  final String nome;
  final String descricao;

  Produto({this.id, this.nome, this.descricao});

  // factory Produto.fromJson(Map<String, dynamic> json) {
  //   return Produto(
  //     id: json['id'],
  //     descricao: json['descricao'],
  //   );
  // }
  //outra notação 
  Produto.fromJson(Map json)
      : id = json['id'],
        nome = json['nome'],
        descricao = json['descricao'];

  Map toJson() {
    return {'id': id, nome: 'nome', 'descricao': descricao};
  }

}