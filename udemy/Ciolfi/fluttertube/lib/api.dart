import 'dart:convert';
import 'dart:core';

import 'package:http/http.dart';

import 'models/video.dart';
const API_KEY = 'AIzaSyDAffoDChEmLegegSvbiCMt_x5i2W-40fI';
String _nextToken;
String _search;

class Api{
  Future<List<Video>> serach(String search )async {
    _search = search;
    Response response = await get(
      "https://www.googleapis.com/youtube/v3/search?part=snippet&q=$search&type=video&key=$API_KEY&maxResults=10"
    );
    return decode(response);
  }

  Future<List<Video>> nextPage()async{
    Response response = await get(
      "https://www.googleapis.com/youtube/v3/search?part=snippet&q=$_search&type=video&key=$API_KEY&maxResults=10&pageToken=$_nextToken"
    );
    return decode(response);
  }

  List<Video> decode(Response response){
    if( response.statusCode == 200 ){
      var decoded = json.decode(response.body);
      _nextToken = decoded["nextPageToken"];
      List<Video> videos = decoded['items'].map<Video>( (data)=> Video.fromJson(data)).toList();
      return  videos;
    }else{
      throw Exception("Failed to load videos");
    }
  }
}
//
//"https://www.googleapis.com/youtube/v3/search?part=snippet&q=$_search&type=video&key=$API_KEY&maxResults=10&pageToken=$_nextToken"
//"http://suggestqueries.google.com/complete/search?hl=en&ds=yt&client=youtube&hjson=t&cp=1&q=$search&format=5&alt=json"