
class Metadata{
  int generated;
  String url;
  String title;
  int status;
  String api;
  int count;

  Metadata.fromJson(Map json)
      : generated = json['generated'],
        url = json['url'],
        title = json['title'],
        status = json['status'],
        api = json['api'],
        count = json['count']
        ;

  Map toJson() {
    return {'generated': generated, 'url': url, 'title': title, 'status':status,'api':api, 'count':count };
  }
}
