import 'dart:async';
import 'dart:convert';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:fluttertube/models/video.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesBloc implements BlocBase{
  Map<String,Video> _favorites = {};    

  final BehaviorSubject<Map<String,Video>> _favController = BehaviorSubject<Map<String,Video>>.seeded({});
  Stream<Map<String,Video>> get outFav => _favController.stream;

  FavoritesBloc(){
    SharedPreferences.getInstance().then((prefs){
      if( prefs.getKeys().contains("favorites")){
        var decoded = json.decode(prefs.getString("favorites"));
        _favorites = decoded.map((k,v){
          return MapEntry(k, Video.fromJson(v));
        }).cast<String,Video>();
        _favController.sink.add(_favorites);
      }
    });
  }



  void toogleFavorite(Video video){
    if( _favorites.containsKey(video.id)) 
      _favorites.remove(video.id);
    else 
      _favorites[video.id] = video;
    _favController.sink.add(_favorites);
    _saveFav();
  }

  void _saveFav(){
    SharedPreferences.getInstance().then((prefs){
      prefs.setString("favorites", json.encode(_favorites));
    });
  }
  @override
  void addListener(listener) {
    // TODO: implement addListener
  }

  @override
  void dispose() {
    _favController.close();
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

}