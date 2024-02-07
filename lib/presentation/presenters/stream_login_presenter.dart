// ignore_for_file: unnecessary_null_comparison

import 'dart:async';

import '../protocols/validation.dart';

class LoginState {
  late String ?emailError;
}

class StreamLoginPresenter {
  final Validation validation;
  final _controller = StreamController<LoginState>.broadcast();

  final _state = LoginState();

  Stream<String?> get emailErrorStream => _controller.stream.map((state) => state.emailError).distinct();

  StreamLoginPresenter({required this.validation});

  void validateEmail(String email) {  
    _state.emailError = validation.validate(field: 'email', value: email);
    _controller.add(_state);
  }
}