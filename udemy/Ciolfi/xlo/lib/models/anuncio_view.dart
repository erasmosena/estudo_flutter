import 'dart:convert';

import 'package:xlo/models/address.dart';

class AnuncioView {
  List<dynamic> images;
  String title; 
  String description;
  Address address;
  num price;
  bool hidePhone;

  AnuncioView({
    this.images,
    this.title,
    this.description,
    this.address,
    this.price,
    this.hidePhone,
  });

  

  Map<String, dynamic> toMap() {
    return {
      'images': images,
      'title': title,
      'description': description,
      'address': address?.toMap(),
      'price': price,
      'hidePhone': hidePhone,
    };
  }

  static AnuncioView fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return AnuncioView(
      images: List<dynamic>.from(map['images']),
      title: map['title'],
      description: map['description'],
      address: Address.fromMap(map['address']),
      price: map['price'],
      hidePhone: map['hidePhone'],
    );
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return "$images, $title, $description, $address, $price, $hidePhone";
  }

  static AnuncioView fromJson(String source) => fromMap(json.decode(source));
}
