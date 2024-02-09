import 'package:faker/faker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'package:fordev/presentation/presenters/presenters.dart';

import '../mocks/mocks.dart';



void main() {
    late StreamLoginPresenter sut;
    late ValidationSpy validation;
    late String email;
    late String password;

  setUp(() {
    validation = ValidationSpy();
    sut = StreamLoginPresenter(validation: validation);
    email = faker.internet.email();
    password = faker.internet.password();
    validation.mockValidation();
  });
  test('should call validation with correct email', () {
    sut.validateEmail(email);

    verify(() => validation.validate(field: 'email', value: email)).called(1);
  });
  
  test('should emit email error if validaton fails', () {
    validation.mockValidation(value: 'error');

    sut.emailErrorStream.listen(expectAsync1((error) => expect(error, 'error')));
    sut.isFormValidStream.listen(expectAsync1((isValid) => expect(isValid, false)));
    
    sut.validateEmail(email);
    sut.validateEmail(email);    
  });


test('should emit email null if validaton succeed', () {
    validation.mockValidation();

    sut.emailErrorStream.listen(expectAsync1((error) => expect(error, null)));
    sut.isFormValidStream.listen(expectAsync1((isValid) => expect(isValid, false)));
    
    sut.validateEmail(email);
    sut.validateEmail(email);
  });


  test('should call validation with correct password', () {
    sut.validatePassword(password);

    verify(() => validation.validate(field: 'password', value: password)).called(1);
  });

}