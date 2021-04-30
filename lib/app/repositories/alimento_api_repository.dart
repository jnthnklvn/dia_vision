import 'package:dia_vision/app/shared/utils/http_connection.dart';
import 'package:dia_vision/app/errors/alimento_failure.dart';
import 'package:dia_vision/app/model/alimento.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class AlimentoAPIRepository {
  final Dio _dio;
  final _endpoint =
      "https://api.myfitnesspal.com/public/nutrition?page=1&per_page=30&q=";

  AlimentoAPIRepository(this._dio);

  Future<Either<AlimentoFailure, List<Alimento>>> getAlimentos(
      String alimento) async {
    final response = await _dio.get(_endpoint + alimento);

    if (response.statusCode == HTTP_OK) {
      final items = response?.data["items"];
      return Right(items?.map<Alimento>((r) => toModel(r))?.toList());
    } else {
      return Left(AlimentoFailure(response.statusMessage, response.statusCode));
    }
  }

  Alimento toModel(Map map) => Alimento().fromAPIJson(map);
}
