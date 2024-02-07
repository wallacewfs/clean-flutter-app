import 'package:mocktail/mocktail.dart';

import '../presenters/stream_login_presenter_test.dart';

class ValidationSpy extends Mock implements Validation {
  var _;

  ValidationSpy() {
    mockValidation();
  }

  When mockValidationCall(String? field) => when(() => validate(field: any(named: 'field') , value: any(named: 'value')));
  void mockValidation({ String? field }) => mockValidationCall(field).thenReturn('');
//  void mockValidationError({ String? field, required ValidationError value }) => this.mockValidationCall(field).thenReturn(value);
}