// ignore_for_file: unnecessary_null_comparison

import 'dart:async';

import '../protocols/validation.dart';

class LoginState {
  late String emailError;

  bool get isFormValid => false;
}

class StreamLoginPresenter {
  Validation validation;
  final _controller = StreamController<LoginState>.broadcast();

  var _state = LoginState();

  Stream<String> get emailErrorStream => _controller.stream.map((state) => state.emailError).distinct();
  Stream<bool> get isFormValidStream => _controller.stream.map((state) => state.isFormValid).distinct();

  StreamLoginPresenter({ required this.validation });

  void validateEmail(String email) {  
    _state.emailError = validation.validate(field: 'email', value: email);
    _controller.add(_state);
  }

  void validatePassword(String password) {  
    validation.validate(field: 'password', value: password);
  }

}