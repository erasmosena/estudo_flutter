
import 'features.dart';
import 'metadata.dart';

class Terremoto
{
  Terremoto();
  String type;
  Metadata metadata;
  List features;
  List bbox;

  Terremoto.fromJson(Map json)
      : type = json['type'],
        metadata = Metadata.fromJson(json['metadata']),
        features = json['features'].map((model)=> Feature.fromJson(model)).toList(),
        bbox = json['bbox'];

  Map toJson() {
    return {'type': type, 'metadata': metadata, 'features': features, 'bbox':bbox};
  }

}


