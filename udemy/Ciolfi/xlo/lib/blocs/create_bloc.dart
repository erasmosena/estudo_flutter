import 'package:rxdart/rxdart.dart';
import 'package:xlo/models/anuncio_view.dart';

enum CreateState { IDLE, LOADING, DONE }

class CreateBloc {
  final BehaviorSubject<CreateState> _stateController =
      BehaviorSubject<CreateState>.seeded(CreateState.IDLE);

  Future<bool> saveAdd(AnuncioView anuncio) async {
    _stateController.add(CreateState.LOADING);

    //enviar para o repositório

    await Future.delayed(Duration(seconds: 3));
    _stateController.add(CreateState.DONE);
    return true;
  }

  Stream<CreateState> get outState => _stateController.stream;


  void dispose(){
    _stateController.close();
  }

}
