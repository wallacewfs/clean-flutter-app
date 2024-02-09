import 'package:fordev/presentation/protocols/validation.dart';
import 'package:mocktail/mocktail.dart';

class ValidationSpy extends Mock implements Validation {
 /* 
  ValidationSpy() {
    mockValidation();
  }
*/
  When mockValidationCall(String? field) => when(() => validate(field: field ?? any(named: 'field') , value: any(named: 'value')));
  void mockValidation({ String? field , String? value }) => mockValidationCall(field).thenReturn(null);
  void mockValidationError({ String? field, required String value }) => mockValidationCall(field).thenReturn(value);
}