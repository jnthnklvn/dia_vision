import 'package:dia_vision/app/repositories/errors/atividade_fisica_failure.dart';
import 'package:dia_vision/app/shared/utils/parse_errors.dart';
import 'package:dia_vision/app/repositories/model/atividade_fisica.dart';
import 'package:dia_vision/app/repositories/model/paciente.dart';
import 'package:dia_vision/app/repositories/model/user.dart';

import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:dartz/dartz.dart';

abstract class IAtividadeFisicaRepository {
  Future<Either<AtividadeFisicaFailure, List<AtividadeFisica>>> getAll(
      Paciente paciente);
  Future<Either<AtividadeFisicaFailure, AtividadeFisica>> getById(
      String objectId);
  Future<Either<AtividadeFisicaFailure, AtividadeFisica>> save(
      AtividadeFisica atividadeFisica, User user);
}

class AtividadeFisicaRepository implements IAtividadeFisicaRepository {
  @override
  Future<Either<AtividadeFisicaFailure, AtividadeFisica>> save(
      AtividadeFisica atividadeFisica, User user) async {
    final acl = ParseACL(owner: user);
    atividadeFisica.setACL(acl);
    final response = await atividadeFisica.save();

    return _getSingleResult(response);
  }

  @override
  Future<Either<AtividadeFisicaFailure, AtividadeFisica>> getById(
      String objectId) async {
    final query = QueryBuilder(AtividadeFisica.clone())
      ..whereEqualTo("objectId", objectId)
      ..includeObject(['paciente']);
    final response = await query.query();

    return _getSingleResult(response);
  }

  @override
  Future<Either<AtividadeFisicaFailure, List<AtividadeFisica>>> getAll(
      Paciente paciente) async {
    final query = QueryBuilder(AtividadeFisica.clone())
      ..whereEqualTo('paciente', paciente)
      ..orderByDescending("createdAt");
    final response = await query.query();

    return _getResult(response);
  }

  Either<AtividadeFisicaFailure, List<AtividadeFisica>> _getResult(
      ParseResponse response) {
    if (response.success) {
      final result =
          response.results?.map((e) => e as AtividadeFisica).toList();
      return Right(result ?? []);
    } else {
      return Left(_getFailure(response));
    }
  }

  Either<AtividadeFisicaFailure, AtividadeFisica> _getSingleResult(
      ParseResponse response) {
    if (response.success) {
      final result =
          response.result is List ? response.result[0] : response.result;
      return Right(result);
    } else {
      return Left(_getFailure(response));
    }
  }

  AtividadeFisicaFailure _getFailure(ParseResponse response) {
    return AtividadeFisicaFailure(
      ParseErrors.getDescription(response.error?.code),
      response.error?.code ?? -2,
    );
  }
}
