import 'package:dia_vision/app/shared/utils/parse_errors.dart';
import 'package:dia_vision/app/errors/diurese_failure.dart';
import 'package:dia_vision/app/model/diurese.dart';
import 'package:dia_vision/app/model/paciente.dart';
import 'package:dia_vision/app/model/user.dart';

import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:dartz/dartz.dart';

abstract class IDiureseRepository {
  Future<Either<DiureseFailure, List<Diurese>>> getAllByPaciente(
      Paciente paciente);
  Future<Either<DiureseFailure, Diurese>> getById(String objectId);
  Future<Either<DiureseFailure, Diurese>> save(Diurese diurese, User user);
}

class DiureseRepository implements IDiureseRepository {
  @override
  Future<Either<DiureseFailure, Diurese>> save(
      Diurese diurese, User user) async {
    final acl = ParseACL(owner: user);
    diurese.setACL(acl);
    final response = await diurese.save();

    return _getSingleResult(response);
  }

  @override
  Future<Either<DiureseFailure, Diurese>> getById(String objectId) async {
    final query = QueryBuilder(Diurese.clone())
      ..whereEqualTo("objectId", objectId)
      ..includeObject(['paciente']);
    final response = await query.query();

    return _getSingleResult(response);
  }

  @override
  Future<Either<DiureseFailure, List<Diurese>>> getAllByPaciente(
      Paciente paciente) async {
    final query = QueryBuilder(Diurese.clone())
      ..whereEqualTo('paciente', paciente)
      ..orderByDescending("createdAt");
    final response = await query.query();

    return _getResult(response);
  }

  Either<DiureseFailure, List<Diurese>> _getResult(ParseResponse response) {
    if (response.success && response.results != null) {
      final result = response.results!.map((e) => e as Diurese).toList();
      return Right(result);
    } else {
      return Left(_getFailure(response));
    }
  }

  Either<DiureseFailure, Diurese> _getSingleResult(ParseResponse response) {
    if (response.success) {
      final result =
          response.result is List ? response.result[0] : response.result;
      return Right(result);
    } else {
      return Left(_getFailure(response));
    }
  }

  DiureseFailure _getFailure(ParseResponse response) {
    return DiureseFailure(
      ParseErrors.getDescription(response.error?.code),
      response.error?.code ?? -2,
    );
  }
}
