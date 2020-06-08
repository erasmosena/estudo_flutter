import 'dart:convert';

class Address {
  String cep;
  String logradouro;
  String complemento;
  String bairro;
  String localidade;
  String uf;
  String unidade;
  String ibge;
  String gia;

  Address({
    this.cep,
    this.logradouro,
    this.complemento,
    this.bairro,
    this.localidade,
    this.uf,
    this.unidade,
    this.ibge,
    this.gia,
  });

  @override
  String toString() {
    return '$logradouro${this.complemento.isNotEmpty ? this.complemento + ", " : ""}, $bairro - $localidade / $uf  $cep';
  }

  Map<String, dynamic> toMap() {
    return {
      'cep': cep,
      'logradouro': logradouro,
      'complemento': complemento,
      'bairro': bairro,
      'localidade': localidade,
      'uf': uf,
      'unidade': unidade,
      'ibge': ibge,
      'gia': gia,
    };
  }

  static Address fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Address(
      cep: map['cep'],
      logradouro: map['logradouro'],
      complemento: map['complemento'],
      bairro: map['bairro'],
      localidade: map['localidade'],
      uf: map['uf'],
      unidade: map['unidade'],
      ibge: map['ibge'],
      gia: map['gia'],
    );
  }

  String toJson() => json.encode(toMap());

  static Address fromJson(String source) => fromMap(json.decode(source));
}
