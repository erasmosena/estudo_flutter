
class Terremoto
{
  String type;
  Metadata metadata;
  List<Feature> features;
  List<double> bbox;
}

class Feature{
  String type;
  List<Property> properties;
  Geometry geometry;
  String id;
}

class Geometry{
  String type;
  List<double> coordinates;
}

class Property{
  double mag ;
  String place;
  int time;
  int updated;
  int tz;
  String url;
  String detail ;
  String felt ;
  String cdi ;
  String mmi ;
  String alert ;
  String status ;
  int tsunami ;
  int sig ;
  String net ;
  String code ;
  String ids ;
  String sources ;
  String types ;
  int nst ;
  int dmin ;
  int rms ;
  int gap ;
  String magType ;
  String type ;
  String title ;
}

class Metadata{
  int generated;
  String url;
  String title;
  int status;
  String api;
  int count;
}
