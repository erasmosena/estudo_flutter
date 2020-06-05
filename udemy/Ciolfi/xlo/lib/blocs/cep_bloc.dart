import 'package:rxdart/rxdart.dart';
import 'package:xlo/api/api_cep.dart';
import 'package:xlo/models/address.dart';
import 'package:xlo/repositories/api_response.dart';

enum CepFieldState { INITIALIZING, INCOMPLETE, INVALID, VALID }

class CepBlocState {
  CepBlocState({
    this.cepFieldState,
    this.cep,
    this.address,
  });

  CepFieldState cepFieldState;
  String cep;
  Address address;
}

class CepBloc {
  final BehaviorSubject<CepBlocState> _cepController =
      BehaviorSubject<CepBlocState>();

  Stream get outCep => _cepController.stream;

  void _searchCep(String cep) async {
    final ApiResponse apiResponse = await getAddressFromAPI(cep);
    if (apiResponse.success) {
      _cepController.add(CepBlocState(
        cepFieldState: CepFieldState.VALID,
        cep: cep,
        address: apiResponse.result,
      ));
    } else {
      _cepController.add(CepBlocState(
        cepFieldState: CepFieldState.INVALID,
        cep: cep,
      ));
    }
  }

  void onChanged(String cep) {
    cep = cep.trim().replaceAll("-", "").replaceAll(".", "");
    if (cep.isEmpty || cep.length < 8) {
      _cepController.add(CepBlocState(
        cepFieldState: CepFieldState.INCOMPLETE,
        cep: cep,
      ));
    } else {
      _searchCep(cep);
    }
  }
}
