import 'package:dia_vision/app/errors/centro_saude_failure.dart';
import 'package:dia_vision/app/shared/utils/parse_errors.dart';
import 'package:dia_vision/app/model/centro_saude.dart';

import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:dartz/dartz.dart';

abstract class ICentroSaudeRepository {
  Future<Either<CentroSaudeFailure, List<CentroSaude>>> getAll();
  Future<Either<CentroSaudeFailure, CentroSaude>> getById(String objectId);
  Future<Either<CentroSaudeFailure, CentroSaude>> save(CentroSaude centroSaude);
}

class CentroSaudeRepository implements ICentroSaudeRepository {
  @override
  Future<Either<CentroSaudeFailure, CentroSaude>> save(
      CentroSaude centroSaude) async {
    final acl = ParseACL();
    acl.setPublicReadAccess(allowed: true);
    centroSaude.setACL(acl);
    final response = await centroSaude.save();

    return _getSingleResult(response);
  }

  Future<Either<CentroSaudeFailure, CentroSaude>> getById(
      String objectId) async {
    final query = QueryBuilder(CentroSaude.clone())
      ..whereEqualTo("objectId", objectId)
      ..includeObject(['endereco']);
    final response = await query.query();

    return _getSingleResult(response);
  }

  Future<Either<CentroSaudeFailure, List<CentroSaude>>> getAll() async {
    final query = QueryBuilder(CentroSaude.clone())
      ..whereEqualTo('verificado', true)
      ..includeObject(['endereco'])
      ..orderByDescending("createdAt");
    final response = await query.query();

    return _getResult(response);
  }

  Either<CentroSaudeFailure, List<CentroSaude>> _getResult(
      ParseResponse response) {
    if (response.success) {
      final result = response.results?.map((e) => e as CentroSaude)?.toList();
      return Right(result);
    } else
      return Left(_getFailure(response));
  }

  Either<CentroSaudeFailure, CentroSaude> _getSingleResult(
      ParseResponse response) {
    if (response.success) {
      final result =
          response.result is List ? response.result[0] : response.result;
      return Right(result);
    } else
      return Left(_getFailure(response));
  }

  CentroSaudeFailure _getFailure(ParseResponse response) {
    return CentroSaudeFailure(
      ParseErrors.getDescription(response.error.code),
      response.error.code,
    );
  }
}
