import 'package:dia_vision/app/errors/medicacao_prescrita_failure.dart';
import 'package:dia_vision/app/shared/utils/parse_errors.dart';
import 'package:dia_vision/app/model/medicacao_prescrita.dart';
import 'package:dia_vision/app/model/paciente.dart';
import 'package:dia_vision/app/model/user.dart';

import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:dartz/dartz.dart';

abstract class IMedicacaoPrescritaRepository {
  Future<Either<MedicacaoPrescritaFailure, List<MedicacaoPrescrita>>>
      getAllByPaciente(Paciente paciente);
  Future<Either<MedicacaoPrescritaFailure, MedicacaoPrescrita>> getById(
      String objectId);
  Future<Either<MedicacaoPrescritaFailure, MedicacaoPrescrita>> save(
      MedicacaoPrescrita medicacao, User user);
}

class MedicacaoPrescritaRepository implements IMedicacaoPrescritaRepository {
  @override
  Future<Either<MedicacaoPrescritaFailure, MedicacaoPrescrita>> save(
      MedicacaoPrescrita medicacao, User user) async {
    final acl = ParseACL(owner: user);
    medicacao.setACL(acl);
    final response = await medicacao.save();

    return _getSingleResult(response);
  }

  Future<Either<MedicacaoPrescritaFailure, MedicacaoPrescrita>> getById(
      String objectId) async {
    final query = QueryBuilder(MedicacaoPrescrita.clone())
      ..whereEqualTo("objectId", objectId)
      ..includeObject(['paciente'])
      ..includeObject(['medicamento']);
    final response = await query.query();

    return _getSingleResult(response);
  }

  Future<Either<MedicacaoPrescritaFailure, List<MedicacaoPrescrita>>>
      getAllByPaciente(Paciente paciente) async {
    final query = QueryBuilder(MedicacaoPrescrita.clone())
      ..whereEqualTo('paciente', paciente)
      ..includeObject(['paciente'])
      ..includeObject(['medicamento'])
      ..orderByDescending("createdAt");
    final response = await query.query();

    return _getResult(response);
  }

  Either<MedicacaoPrescritaFailure, List<MedicacaoPrescrita>> _getResult(
      ParseResponse response) {
    if (response.success) {
      final result =
          response.results?.map((e) => e as MedicacaoPrescrita)?.toList();
      return Right(result);
    } else
      return Left(_getFailure(response));
  }

  Either<MedicacaoPrescritaFailure, MedicacaoPrescrita> _getSingleResult(
      ParseResponse response) {
    if (response.success) {
      final result =
          response.result is List ? response.result[0] : response.result;
      return Right(result);
    } else
      return Left(_getFailure(response));
  }

  MedicacaoPrescritaFailure _getFailure(ParseResponse response) {
    return MedicacaoPrescritaFailure(
      ParseErrors.getDescription(response.error.code),
      response.error.code,
    );
  }
}
