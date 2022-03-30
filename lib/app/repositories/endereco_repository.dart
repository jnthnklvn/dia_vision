import 'package:dia_vision/app/shared/utils/parse_errors.dart';
import 'package:dia_vision/app/errors/endereco_failure.dart';
import 'package:dia_vision/app/model/endereco.dart';

import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:dartz/dartz.dart';

abstract class IEnderecoRepository {
  Future<Either<EnderecoFailure, Endereco>> getById(String objectId);
  Future<Either<EnderecoFailure, Endereco>> save(Endereco endereco);
}

class EnderecoRepository implements IEnderecoRepository {
  @override
  Future<Either<EnderecoFailure, Endereco>> save(Endereco endereco) async {
    final acl = ParseACL();
    endereco.setACL(acl);
    final response = await endereco.save();

    return _getSingleResult(response);
  }

  @override
  Future<Either<EnderecoFailure, Endereco>> getById(String objectId) async {
    final query = QueryBuilder(Endereco.clone())
      ..whereEqualTo("objectId", objectId);
    final response = await query.query();

    return _getSingleResult(response);
  }

  Either<EnderecoFailure, Endereco> _getSingleResult(ParseResponse response) {
    if (response.success) {
      final result =
          response.result is List ? response.result[0] : response.result;
      return Right(result);
    } else {
      return Left(_getFailure(response));
    }
  }

  EnderecoFailure _getFailure(ParseResponse response) {
    return EnderecoFailure(
      ParseErrors.getDescription(response.error?.code),
      response.error?.code ?? -2,
    );
  }
}
