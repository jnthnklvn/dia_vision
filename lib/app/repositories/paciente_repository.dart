import 'package:dia_vision/app/shared/utils/parse_errors.dart';
import 'package:dia_vision/app/errors/paciente_failure.dart';
import 'package:dia_vision/app/model/paciente.dart';
import 'package:dia_vision/app/model/user.dart';

import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:dartz/dartz.dart';

abstract class IPacienteRepository {
  Future<Either<PacienteFailure, Paciente>> getByUser(User user);
  Future<Either<PacienteFailure, Paciente>> getById(String objectId);
  Future<Either<PacienteFailure, Paciente>> savePaciente(Paciente paciente);
}

class PacienteRepository implements IPacienteRepository {
  @override
  Future<Either<PacienteFailure, Paciente>> savePaciente(
      Paciente paciente) async {
    final acl = ParseACL(owner: paciente.user);
    acl.setPublicReadAccess(allowed: true);
    paciente.setACL(acl);
    final response = await paciente.save();

    return getResult(response);
  }

  Future<Either<PacienteFailure, Paciente>> getById(String objectId) async {
    final query = QueryBuilder(Paciente.clone())
      ..whereEqualTo("objectId", objectId);
    final response = await query.query();
    return getResult(response);
  }

  Future<Either<PacienteFailure, Paciente>> getByUser(User user) async {
    final query = QueryBuilder(Paciente.clone())
      ..includeObject(['user'])
      ..whereEqualTo('user', user);
    final response = await query.query();

    return getResult(response);
  }

  Future<Either<PacienteFailure, Paciente>> getResult(ParseResponse response) {
    print(response?.result);
    if (response.success) {
      final result =
          response.result is List ? response.result[0] : response.result;
      return Future.value(Right(result));
    } else {
      return Future.value(Left(PacienteFailure(
        ParseErrors.getDescription(response.error.code),
        response.error.code,
      )));
    }
  }
}
