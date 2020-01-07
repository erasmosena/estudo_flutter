class Usuario {
  int _id;
  String _nome;
  String _senha;

  Usuario(this._nome, this._senha);

  Usuario.map(dynamic obj) {
    this._id = obj['id'];
    this._nome = obj['nome'];
    this._senha = obj['senha'];
  }

  int get id => _id;
  String get nome => _nome;
  String get senha => _senha;

  Map<String, dynamic> toMap() {
    var mapa = Map<String, dynamic>();
    mapa['id'] = _id;
    mapa['nome'] = nome;
    if (_id != null) {
      mapa['id'] = _id;
    }
    return mapa;
  }

  Usuario.fromMap(Map<String,dynamic> mapa){
    this._id = mapa['id'];
    this._nome = mapa['nome'];
    this._senha = mapa['senha'];
  }

}
