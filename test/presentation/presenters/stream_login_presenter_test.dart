import 'package:faker/faker.dart';
import 'package:test/test.dart';

import 'package:fordev/presentation/presenters/presenters.dart';
import '../mocks/mocks.dart';

void main() {
    late StreamLoginPresenter sut;
    late ValidationSpy validation;
    late String email;

  setUp(() {
    validation = ValidationSpy();
    sut = StreamLoginPresenter(validation: validation);
    email = faker.internet.email();
    validation.mockValidation();
  });
  /*
  test('should call validation with correct email', () {
    sut.validateEmail(email);

    verify(() => validation.validate(field: 'email', value: email)).called(1);
  });
*/
  test('should emit email error if validaton fails', () {
    validation.mockValidation(value: 'error');

    sut.emailErrorStream.listen(expectAsync1((error) => expect(error, 'error')));
    
    sut.validateEmail(email);
    sut.validateEmail(email);
    
  });

}