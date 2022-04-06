import 'package:dia_vision/app/shared/utils/parse_errors.dart';
import 'package:dia_vision/app/errors/alimento_failure.dart';
import 'package:dia_vision/app/model/alimentacao.dart';
import 'package:dia_vision/app/model/alimento.dart';
import 'package:dia_vision/app/model/user.dart';

import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:dartz/dartz.dart';

abstract class IAlimentoRepository {
  Future<Either<AlimentoFailure, List<Alimento>>> getAllByAlimentacao(
      Alimentacao alimentacao);
  Future<Either<AlimentoFailure, Alimento>> getById(String objectId);
  Future<Either<AlimentoFailure, Alimento>> save(Alimento alimento, User user);
}

class AlimentoRepository implements IAlimentoRepository {
  @override
  Future<Either<AlimentoFailure, Alimento>> getById(String objectId) async {
    final query = QueryBuilder(Alimento.clone())
      ..whereEqualTo("objectId", objectId);
    final response = await query.query();

    return _getSingleResult(response);
  }

  @override
  Future<Either<AlimentoFailure, List<Alimento>>> getAllByAlimentacao(
      Alimentacao alimentacao) async {
    final query = QueryBuilder(Alimento.clone())
      ..whereEqualTo('alimentacao', alimentacao)
      ..orderByDescending("createdAt");
    final response = await query.query();

    return _getResult(response);
  }

  Either<AlimentoFailure, List<Alimento>> _getResult(ParseResponse response) {
    if (response.success && response.results != null) {
      final result = response.results?.map((e) => e as Alimento).toList();
      return Right(result ?? []);
    } else {
      return Left(_getFailure(response));
    }
  }

  Either<AlimentoFailure, Alimento> _getSingleResult(ParseResponse response) {
    if (response.success) {
      final result =
          response.result is List ? response.result[0] : response.result;
      return Right(result);
    } else {
      return Left(_getFailure(response));
    }
  }

  AlimentoFailure _getFailure(ParseResponse response) {
    return AlimentoFailure(
      ParseErrors.getDescription(response.error?.code),
      response.error?.code ?? -2,
    );
  }

  @override
  Future<Either<AlimentoFailure, Alimento>> save(
      Alimento alimento, User user) async {
    final acl = ParseACL(owner: user);
    acl.setPublicReadAccess(allowed: true);
    alimento.setACL(acl);
    final response = await alimento.save();

    return _getSingleResult(response);
  }
}
