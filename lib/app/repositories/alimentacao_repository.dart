import 'package:dia_vision/app/errors/alimentacao_failure.dart';
import 'package:dia_vision/app/shared/utils/parse_errors.dart';
import 'package:dia_vision/app/model/alimentacao.dart';
import 'package:dia_vision/app/model/paciente.dart';
import 'package:dia_vision/app/model/user.dart';

import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:dartz/dartz.dart';

abstract class IAlimentacaoRepository {
  Future<Either<AlimentacaoFailure, List<Alimentacao>>> getAllByPaciente(
      Paciente paciente);
  Future<Either<AlimentacaoFailure, Alimentacao>> getById(String objectId);
  Future<Either<AlimentacaoFailure, Alimentacao>> save(
      Alimentacao alimentacao, User user);
}

class AlimentacaoRepository implements IAlimentacaoRepository {
  Future<Either<AlimentacaoFailure, Alimentacao>> getById(
      String objectId) async {
    final query = QueryBuilder(Alimentacao.clone())
      ..whereEqualTo("objectId", objectId);
    final response = await query.query();

    return _getSingleResult(response);
  }

  Future<Either<AlimentacaoFailure, List<Alimentacao>>> getAllByPaciente(
      Paciente paciente) async {
    final query = QueryBuilder(Alimentacao.clone())
      ..whereEqualTo('paciente', paciente)
      ..orderByDescending("createdAt");
    final response = await query.query();

    return _getResult(response);
  }

  Either<AlimentacaoFailure, List<Alimentacao>> _getResult(
      ParseResponse response) {
    if (response.success) {
      final result = response.results?.map((e) => e as Alimentacao)?.toList();
      return Right(result);
    } else
      return Left(_getFailure(response));
  }

  Either<AlimentacaoFailure, Alimentacao> _getSingleResult(
      ParseResponse response) {
    if (response.success) {
      final result =
          response.result is List ? response.result[0] : response.result;
      return Right(result);
    } else
      return Left(_getFailure(response));
  }

  AlimentacaoFailure _getFailure(ParseResponse response) {
    return AlimentacaoFailure(
      ParseErrors.getDescription(response.error.code),
      response.error.code,
    );
  }

  @override
  Future<Either<AlimentacaoFailure, Alimentacao>> save(
      Alimentacao alimentacao, User user) async {
    final acl = ParseACL(owner: user);
    alimentacao.setACL(acl);
    final response = await alimentacao.save();

    return _getSingleResult(response);
  }
}
