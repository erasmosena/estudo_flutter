import 'dart:async';

import 'package:fluttertube/api.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:fluttertube/models/video.dart';
import 'package:rxdart/rxdart.dart';

class VideosBloc implements BlocBase {
  Api api;

  final BehaviorSubject<List<Video>> _videosController = BehaviorSubject<List<Video>>.seeded([]);
  final StreamController<String> _searchController = StreamController();

  Stream get outVideos => _videosController.stream;
  Sink get inSearchController =>_searchController.sink;   

  List<Video> videos;

  VideosBloc() {
    api = Api();
    _searchController.stream.listen(_search);
  }



  @override
  void dispose() {
    _videosController.close();
    _searchController.close();
  }

  @override
  void addListener(listener) {
    // TODO: implement addListener
  }

  @override
  // TODO: implement hasListeners
  bool get hasListeners => null;

  @override
  void notifyListeners() {
    // TODO: implement notifyListeners
  }

  @override
  void removeListener(listener) {
    // TODO: implement removeListener
  }

  void _search(String search) async {
    if(search != null ){
      _videosController.sink.add([]);
      videos = await api.serach(search) ;
    }
    else   
      videos += await api.nextPage();

    _videosController.sink.add(videos);
  }


}
