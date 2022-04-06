import 'package:dia_vision/app/shared/utils/parse_errors.dart';
import 'package:dia_vision/app/errors/app_visao_failure.dart';
import 'package:dia_vision/app/model/app_visao.dart';

import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:dartz/dartz.dart';

abstract class IAppVisaoRepository {
  Future<Either<AppVisaoFailure, List<AppVisao>>> getAll();
  Future<Either<AppVisaoFailure, AppVisao>> getById(String objectId);
  Future<Either<AppVisaoFailure, AppVisao>> save(AppVisao appVisao);
}

class AppVisaoRepository implements IAppVisaoRepository {
  @override
  Future<Either<AppVisaoFailure, AppVisao>> save(AppVisao appVisao) async {
    final acl = ParseACL();
    acl.setPublicReadAccess(allowed: true);
    appVisao.setACL(acl);
    final response = await appVisao.save();

    return _getSingleResult(response);
  }

  @override
  Future<Either<AppVisaoFailure, AppVisao>> getById(String objectId) async {
    final query = QueryBuilder(AppVisao.clone())
      ..whereEqualTo("objectId", objectId);
    final response = await query.query();

    return _getSingleResult(response);
  }

  @override
  Future<Either<AppVisaoFailure, List<AppVisao>>> getAll() async {
    final query = QueryBuilder(AppVisao.clone())
      ..whereEqualTo('verificado', true)
      ..orderByDescending("createdAt");
    final response = await query.query();

    return _getResult(response);
  }

  Either<AppVisaoFailure, List<AppVisao>> _getResult(ParseResponse response) {
    if (response.success && response.results != null) {
      final result = response.results?.map((e) => e as AppVisao).toList();
      return Right(result ?? []);
    } else {
      return Left(_getFailure(response));
    }
  }

  Either<AppVisaoFailure, AppVisao> _getSingleResult(ParseResponse response) {
    if (response.success) {
      final result =
          response.result is List ? response.result[0] : response.result;
      return Right(result);
    } else {
      return Left(_getFailure(response));
    }
  }

  AppVisaoFailure _getFailure(ParseResponse response) {
    return AppVisaoFailure(
      ParseErrors.getDescription(response.error?.code),
      response.error?.code ?? -2,
    );
  }
}
