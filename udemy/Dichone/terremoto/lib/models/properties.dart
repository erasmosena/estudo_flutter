
class Properties{
  double mag ;
  String place;
  int time;
  int updated;
  int tz;
  String url;
  String detail ;
  int felt ;
  double cdi ;
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
  double dmin ;
  double rms ;
  int gap ;
  String magType ;
  String type ;
  String title ;

  Properties.fromJson(Map json)
      : mag = double.parse(json['mag'].toString()),  
        place = json['place'],
        time = json['time']
        // updated = json['updated'],
        // tz = json['tz'],
        // url = json['url'],
        // detail = json['detail'],
        // felt = json['felt'],
        // cdi = double.parse(json['cdi'].toString()),
        // mmi = json['mmi'],
        // alert = json['alert'],
        // status = json['status'],
        // tsunami = json['tsunami'],
        // sig = json['sig'],
        // net = json['net'],
        // code = json['code'],
        // ids = json['ids'],
        // sources = json['sources'],
        // types = json['types'],
        // nst = json['nst'],
        // dmin = json['dmin'],
        // rms = json['rms'],
        // gap = json['gap'],
        // magType = json['magType'],
        // type = json['type'],
        // title = json['title']
        ;

  Map toJson() {
    return {
      'mag':mag ,
      'place':place,
      'time':time,
      'updated':updated,
      'tz':tz,
      'url':url,
      'detail':detail,
      'felt':felt,
      'cdi':cdi,
      'mmi':mmi,
      'alert':alert,
      'status':status,
      'tsunami':tsunami,
      'sig':sig,
      'net':net,
      'code':code,
      'ids':ids,
      'sources':sources,
      'types':types,
      'nst':nst,
      'dmin':dmin,
      'rms':rms,
      'gap':gap,
      'magType':magType,
      'type':type,
      'title':title
    };
  }
}
