import 'package:dia_vision/app/shared/utils/parse_errors.dart';
import 'package:dia_vision/app/errors/user_failure.dart';
import 'package:dia_vision/app/model/user.dart';

import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:dartz/dartz.dart';

abstract class IUserRepository {
  Future<Either<UserFailure, User>> signUp(User user);
  Future<Either<UserFailure, User>> save(User user);
  Future<Either<UserFailure, User>> login(User user);
  Future<void> logout();
  Future<Either<UserFailure, User>> requestPasswordReset(User user);
  Future<Either<UserFailure, User>> currentUser();
}

class UserRepository implements IUserRepository {
  User createUserObject(String username, String password, String email,
      {UserType userType, String tokenFirebase, String phone}) {
    final user = User(username, password: password, email: email);

    if (phone != null) user.phone = phone;
    if (userType != null) user.userType = userType;
    if (tokenFirebase != null) user.tokenFirebase = tokenFirebase;

    return user;
  }

  @override
  Future<Either<UserFailure, User>> signUp(User user) async {
    user.userType = UserType.Paciente;
    ParseResponse response = await user.signUp();

    return getResult(response);
  }

  @override
  Future<Either<UserFailure, User>> login(User user) async {
    final response = await user.login();

    return getResult(response);
  }

  @override
  Future<void> logout() async {
    final ParseUser user = await ParseUser.currentUser();
    if (user != null) getResult(await user.logout());
  }

  @override
  Future<Either<UserFailure, User>> save(User user) async {
    ParseResponse response = await user.save();

    return getResult(response);
  }

  Future<Either<UserFailure, User>> verificationEmailRequest(User user) async {
    ParseResponse response = await user.verificationEmailRequest();

    return getResult(response);
  }

  Future<Either<UserFailure, User>> requestPasswordReset(User user) async {
    ParseResponse response = await user.requestPasswordReset();

    return getResult(response);
  }

  Future<Either<UserFailure, User>> currentUser() async {
    final ParseUser user = await ParseUser.currentUser();
    if (user == null) return Left(UserFailure("", 0));
    // ignore: invalid_use_of_protected_member
    return Future.value(Right(User.clone()..fromJson(user.toJson(full: true))));
  }

  Future<Either<UserFailure, User>> getResult(ParseResponse response) {
    print(response?.result);
    if (response.success) {
      return Future.value(Right(response.result));
    } else {
      return Future.value(Left(UserFailure(
        ParseErrors.getDescription(response.error.code),
        response.error.code,
      )));
    }
  }
}