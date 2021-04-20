import 'package:dia_vision/app/errors/avaliacao_pes_failure.dart';
import 'package:dia_vision/app/shared/utils/parse_errors.dart';
import 'package:dia_vision/app/model/avaliacao_pes.dart';
import 'package:dia_vision/app/model/paciente.dart';
import 'package:dia_vision/app/model/user.dart';

import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:dartz/dartz.dart';

abstract class IAvaliacaoPesRepository {
  Future<Either<AvaliacaoPesFailure, List<AvaliacaoPes>>> getAllByPaciente(
      Paciente paciente);
  Future<Either<AvaliacaoPesFailure, AvaliacaoPes>> getById(String objectId);
  Future<Either<AvaliacaoPesFailure, AvaliacaoPes>> save(
      AvaliacaoPes avaliacaoPes, User user);
}

class AvaliacaoPesRepository implements IAvaliacaoPesRepository {
  @override
  Future<Either<AvaliacaoPesFailure, AvaliacaoPes>> save(
      AvaliacaoPes avaliacaoPes, User user) async {
    final acl = ParseACL(owner: user);
    acl.setPublicReadAccess(allowed: true);
    avaliacaoPes.setACL(acl);
    final response = await avaliacaoPes.save();

    return _getSingleResult(response);
  }

  Future<Either<AvaliacaoPesFailure, AvaliacaoPes>> getById(
      String objectId) async {
    final query = QueryBuilder(AvaliacaoPes.clone())
      ..whereEqualTo("objectId", objectId)
      ..includeObject(['paciente']);
    final response = await query.query();

    return _getSingleResult(response);
  }

  Future<Either<AvaliacaoPesFailure, List<AvaliacaoPes>>> getAllByPaciente(
      Paciente paciente) async {
    final query = QueryBuilder(AvaliacaoPes.clone())
      ..whereEqualTo('paciente', paciente)
      ..orderByDescending("createdAt");
    final response = await query.query();

    return _getResult(response);
  }

  Either<AvaliacaoPesFailure, List<AvaliacaoPes>> _getResult(
      ParseResponse response) {
    if (response.success) {
      final result = response.results?.map((e) => e as AvaliacaoPes)?.toList();
      return Right(result);
    } else
      return Left(_getFailure(response));
  }

  Either<AvaliacaoPesFailure, AvaliacaoPes> _getSingleResult(
      ParseResponse response) {
    if (response.success) {
      final result =
          response.result is List ? response.result[0] : response.result;
      return Right(result);
    } else
      return Left(_getFailure(response));
  }

  AvaliacaoPesFailure _getFailure(ParseResponse response) {
    return AvaliacaoPesFailure(
      ParseErrors.getDescription(response.error.code),
      response.error.code,
    );
  }
}
