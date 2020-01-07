
class Geometry{
  Geometry({this.type, this.coordinates});

  String type;
  List<double> coordinates;

  // Geometry.fromJson(Map json)
  //     : type = json['type'],
  //       coordinates = json['coordinates'];
  factory Geometry.fromJson(Map<String, dynamic> json) {
    
    return Geometry(
      type: json['type']
    );
  }

  Map toJson() {
    return {'type': type, 'coordinates': coordinates};
  }
}
