class Video{
  final String id;
  final String title;
  final String thumb;
  final String channel;

  Video({this.id, this.title,this.thumb, this.channel});

  factory Video.fromJson(Map<String,dynamic> map){
    return Video(
      id:     map['id']['videoId'],
      title: map['snipet']['title'],
      thumb: map['snipet']['thumbnails']['high']['url'],
      channel: map['snipt']['channelTitle'],
    );
  }

}