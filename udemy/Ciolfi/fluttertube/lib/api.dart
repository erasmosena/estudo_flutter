import 'dart:convert';

import 'package:http/http.dart';

import 'models/video.dart';
const API_KEY = 'AIzaSyDAffoDChEmLegegSvbiCMt_x5i2W-40fI';

class Api{
  serach(String search )async {

    Response response = await get(
      "https://www.googleapis.com/youtube/v3/search?part=snippet&q=$search&type=video&key=$API_KEY&maxResults=10"
    );
    decode(response);
  }

  decode(Response response){
    if( response.statusCode == 200 ){
      var decoded = json.decode(response.body);
      List<Video> videos = decoded['items'].map(
        (map){
          return Video.fromJson((map));
        }
      ).toList();
    }else{
      throw Exception("Failed to load videos");
    }
  }
}
//
//"https://www.googleapis.com/youtube/v3/search?part=snippet&q=$_search&type=video&key=$API_KEY&maxResults=10&pageToken=$_nextToken"
//"http://suggestqueries.google.com/complete/search?hl=en&ds=yt&client=youtube&hjson=t&cp=1&q=$search&format=5&alt=json"