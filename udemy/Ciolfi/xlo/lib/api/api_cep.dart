import 'package:dio/dio.dart';
import 'package:xlo/models/address.dart';
import 'package:xlo/repositories/api_error.dart';
import 'package:xlo/repositories/api_response.dart';

Future<ApiResponse> getAddressFromAPI(String cep) async {
  String codeSanitized = cep.replaceAll(".", "").replaceAll("-", "");
  final String endpoint = 'http://viacep.com.br/ws/$codeSanitized/json/';

  try {
    final Response response = await Dio().get<Map>(endpoint);
    if (response.data.containsKey('erro') && response.data['erro']) {
      return ApiResponse.error(
          error: ApiError(code: -1, message: 'CEP Inválido'));
    }

    Address endereco = Address.fromMap(response.data);
    return ApiResponse.success(
      result: endereco
    );
  } on DioError catch (e) {
    return ApiResponse.error(
        error: ApiError(
            code: -1, message: 'falha na conexão com viacep: ${e.message}'));
  }
}
