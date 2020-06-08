import 'package:rxdart/rxdart.dart';
import 'package:xlo/models/anuncio_view.dart';

class HomeBloc{
  
  final BehaviorSubject<String> _searchController =  BehaviorSubject<String>();
  final BehaviorSubject<List<AnuncioView>> _addController =  BehaviorSubject<List<AnuncioView>>.seeded([]);

  Stream<String> get outSearch => _searchController.stream;
  Stream<List<AnuncioView>> get outAnuncio => _addController.stream.delay(Duration(seconds: 3));

  //temp 
  void adicionarAnuncio(AnuncioView anuncio ){
    _addController.add(_addController.value..add(anuncio));
  }

  void setSearch(String search){
    _searchController.add(search);
  }

  void dispose(){
    _addController.close();
    _searchController.close();
  }
}