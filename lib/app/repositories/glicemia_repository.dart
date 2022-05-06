import 'package:dia_vision/app/shared/utils/parse_errors.dart';
import 'package:dia_vision/app/repositories/errors/glicemia_failure.dart';
import 'package:dia_vision/app/repositories/model/glicemia.dart';
import 'package:dia_vision/app/repositories/model/paciente.dart';
import 'package:dia_vision/app/repositories/model/user.dart';

import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:dartz/dartz.dart';

abstract class IGlicemiaRepository {
  Future<Either<GlicemiaFailure, List<Glicemia>>> getAllByPaciente(
      Paciente paciente);
  Future<Either<GlicemiaFailure, Glicemia>> getById(String objectId);
  Future<Either<GlicemiaFailure, Glicemia>> save(Glicemia glicemia, User user);
}

class GlicemiaRepository implements IGlicemiaRepository {
  @override
  Future<Either<GlicemiaFailure, Glicemia>> save(
      Glicemia glicemia, User user) async {
    final acl = ParseACL(owner: user);
    glicemia.setACL(acl);
    final response = await glicemia.save();

    return _getSingleResult(response);
  }

  @override
  Future<Either<GlicemiaFailure, Glicemia>> getById(String objectId) async {
    final query = QueryBuilder(Glicemia.clone())
      ..whereEqualTo("objectId", objectId)
      ..includeObject(['paciente']);
    final response = await query.query();

    return _getSingleResult(response);
  }

  @override
  Future<Either<GlicemiaFailure, List<Glicemia>>> getAllByPaciente(
      Paciente paciente) async {
    final query = QueryBuilder(Glicemia.clone())
      ..whereEqualTo('paciente', paciente)
      ..orderByDescending("createdAt");
    final response = await query.query();

    return _getResult(response);
  }

  Either<GlicemiaFailure, List<Glicemia>> _getResult(ParseResponse response) {
    if (response.success && response.results != null) {
      final result = response.results?.map((e) => e as Glicemia).toList();
      return Right(result ?? []);
    } else {
      return Left(_getFailure(response));
    }
  }

  Either<GlicemiaFailure, Glicemia> _getSingleResult(ParseResponse response) {
    if (response.success) {
      final result =
          response.result is List ? response.result[0] : response.result;
      return Right(result);
    } else {
      return Left(_getFailure(response));
    }
  }

  GlicemiaFailure _getFailure(ParseResponse response) {
    return GlicemiaFailure(
      ParseErrors.getDescription(response.error?.code),
      response.error?.code ?? -2,
    );
  }
}
