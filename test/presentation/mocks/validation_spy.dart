import 'package:fordev/presentation/protocols/validation.dart';
import 'package:mocktail/mocktail.dart';

class ValidationSpy extends Mock implements Validation {
  ValidationSpy() {
    mockValidation();
  }

  // ignore: prefer_if_null_operators, unnecessary_this
  When mockValidationCall(String? field) => when(() => this.validate(field: field == null ? any(named: 'field') : field , value: any(named: 'value')));
  void mockValidation({ String? field , String? value }) => mockValidationCall(field).thenReturn(value);
//  void mockValidationError({ String? field, required ValidationError value }) => this.mockValidationCall(field).thenReturn(value);
}