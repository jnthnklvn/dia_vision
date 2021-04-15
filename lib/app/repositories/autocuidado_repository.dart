import 'package:dia_vision/app/errors/autocuidado_failure.dart';
import 'package:dia_vision/app/shared/utils/parse_errors.dart';
import 'package:dia_vision/app/model/autocuidado.dart';

import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:dartz/dartz.dart';

abstract class IAutocuidadoRepository {
  Future<Either<AutocuidadoFailure, List<Autocuidado>>> getAll();
  Future<Either<AutocuidadoFailure, Autocuidado>> getById(String objectId);
}

class AutocuidadoRepository implements IAutocuidadoRepository {
  Future<Either<AutocuidadoFailure, Autocuidado>> getById(
      String objectId) async {
    final query = QueryBuilder(Autocuidado.clone())
      ..whereEqualTo("objectId", objectId);
    final response = await query.query();

    return _getSingleResult(response);
  }

  Future<Either<AutocuidadoFailure, List<Autocuidado>>> getAll() async {
    final query = QueryBuilder(Autocuidado.clone());
    final response = await query.query();

    return _getResult(response);
  }

  Either<AutocuidadoFailure, List<Autocuidado>> _getResult(
      ParseResponse response) {
    if (response.success) {
      final result = response.results?.map((e) => e as Autocuidado)?.toList();
      return Right(result);
    } else
      return Left(_getFailure(response));
  }

  Either<AutocuidadoFailure, Autocuidado> _getSingleResult(
      ParseResponse response) {
    if (response.success) {
      final result =
          response.result is List ? response.result[0] : response.result;
      return Right(result);
    } else
      return Left(_getFailure(response));
  }

  AutocuidadoFailure _getFailure(ParseResponse response) {
    return AutocuidadoFailure(
      ParseErrors.getDescription(response.error.code),
      response.error.code,
    );
  }
}
