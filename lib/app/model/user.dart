import 'package:parse_server_sdk/parse_server_sdk.dart';

const keyType = 'type';
const keyEmail = 'email';
const keyPhone = 'phone';
const keyTokenFirebase = 'tokenFirebase';

enum UserType { Paciente, Profissional }

extension UserTypeExtension on UserType {
  String get name => this.toString().replaceAll('UserType.', '');
}

class User extends ParseUser implements ParseCloneable {
  User(String username, {String password, String email})
      : super(username, password, email);

  User.clone() : this(null);
  @override
  User clone(Map<String, dynamic> map) => User.clone()..fromJson(map);

  UserType get userType =>
      UserType.values.firstWhere((e) => e.name == get<String>(keyType));
  set userType(UserType userType) => set<String>(keyType, userType.name);

  String get email => get<String>(keyEmail);
  set email(String email) => set<String>(keyEmail, email);

  String get phone => get<String>(keyPhone);
  set phone(String phone) => set<String>(keyPhone, phone);

  String get tokenFirebase => get<String>(keyTokenFirebase);
  set tokenFirebase(String tokenFirebase) =>
      set<String>(keyTokenFirebase, tokenFirebase);
}
