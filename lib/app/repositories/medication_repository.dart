import 'package:dia_vision/app/model/medicamento.dart';
import 'package:dia_vision/app/shared/utils/parse_errors.dart';
import 'package:dia_vision/app/errors/medicamento_failure.dart';

import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:dartz/dartz.dart';

abstract class IMedicamentoRepository {
  Future<Either<MedicamentoFailure, List<Medicamento>>> getByText(
      String nomeMedicamento,
      {int limit});
  Future<Either<MedicamentoFailure, Medicamento>> getById(String objectId);
}

class MedicamentoRepository implements IMedicamentoRepository {
  @override
  Future<Either<MedicamentoFailure, List<Medicamento>>> getByText(
      String nomeMedicamento,
      {int limit}) async {
    final medicamentoObj = Medicamento.clone();
    final queryNomeSubstancia = QueryBuilder(medicamentoObj)
      ..whereContains("nomeSubstancia", nomeMedicamento);
    final queryNomeComercial = QueryBuilder(medicamentoObj)
      ..whereContains("nomeComercial", nomeMedicamento);

    QueryBuilder<ParseObject> mainQuery = QueryBuilder.or(
      medicamentoObj,
      [queryNomeSubstancia, queryNomeComercial],
    )..setLimit(limit ?? 200);

    final response = await mainQuery.query();
    if (response.success) {
      final result = response.results?.map((e) => e as Medicamento)?.toList();
      return Right(result);
    } else {
      return Left(MedicamentoFailure(
        ParseErrors.getDescription(response.error.code),
        response.error.code,
      ));
    }
  }

  Future<Either<MedicamentoFailure, Medicamento>> getById(
      String objectId) async {
    final query = QueryBuilder(Medicamento.clone())
      ..whereEqualTo("objectId", objectId);
    final response = await query.query();
    if (response.success) {
      final result =
          response.result is List ? response.result[0] : response.result;
      return Right(result);
    } else {
      return Left(MedicamentoFailure(
        ParseErrors.getDescription(response.error.code),
        response.error.code,
      ));
    }
  }
}
