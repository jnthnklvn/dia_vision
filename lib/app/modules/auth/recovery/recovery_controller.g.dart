// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recovery_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$RecoveryController on _RecoveryControllerBase, Store {
  Computed<String> _$emailErrorComputed;

  @override
  String get emailError =>
      (_$emailErrorComputed ??= Computed<String>(() => super.emailError,
              name: '_RecoveryControllerBase.emailError'))
          .value;
  Computed<bool> _$isValidComputed;

  @override
  bool get isValid => (_$isValidComputed ??= Computed<bool>(() => super.isValid,
          name: '_RecoveryControllerBase.isValid'))
      .value;

  final _$emailAtom = Atom(name: '_RecoveryControllerBase.email');

  @override
  String get email {
    _$emailAtom.reportRead();
    return super.email;
  }

  @override
  set email(String value) {
    _$emailAtom.reportWrite(value, super.email, () {
      super.email = value;
    });
  }

  final _$isLoadingAtom = Atom(name: '_RecoveryControllerBase.isLoading');

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  final _$_RecoveryControllerBaseActionController =
      ActionController(name: '_RecoveryControllerBase');

  @override
  void setEmail(String newEmail) {
    final _$actionInfo = _$_RecoveryControllerBaseActionController.startAction(
        name: '_RecoveryControllerBase.setEmail');
    try {
      return super.setEmail(newEmail);
    } finally {
      _$_RecoveryControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
email: ${email},
isLoading: ${isLoading},
emailError: ${emailError},
isValid: ${isValid}
    ''';
  }
}
