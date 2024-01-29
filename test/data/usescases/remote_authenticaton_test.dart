import 'package:faker/faker.dart';
import 'package:mocktail/mocktail.dart';

import 'package:test/test.dart';

import 'package:fordev/domain/helpers/helpers.dart';
import 'package:fordev/domain/usecases/usescase.dart';

import 'package:fordev/data/http/http.dart';
import 'package:fordev/data/usecases/usecases.dart';

import '../mocks/mocks.dart';

void main() {
  late RemoteAuthentication sut;
  late HttpClientSpy httpClient;
  late String url;
  late String email;
  late String secret;
  late AuthenticationParams params;

  
  Map mockvalidData() => { 'accessToken': faker.guid.guid(), 'name': faker.person.name() };

  httpClient = HttpClientSpy(); 

  setUp(() {
    httpClient = HttpClientSpy();
    url = faker.internet.httpUrl();
    email = faker.internet.email();
    secret = faker.internet.password();
    sut = RemoteAuthentication(httpClient: httpClient, url: url);
    params = AuthenticationParams(email: email , secret: secret );    
    httpClient.mockRequest(mockvalidData());
  });
  test('Should call HttpClient with correct values', () async {
    await sut.auth(params);

    verify(() => httpClient.request(
      url: url,
      method: 'post',
      body: {'email' : params.email, 'password': params.secret}
      ));
  });

  test('Should throw UnexpectedError if HttpClient returns 400', () async {
    httpClient.mockRequestError(HttpError.badRequest);

    final future =  sut.auth(params);

    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw UnexpectedError if HttpClient returns 404', () async {
    httpClient.mockRequestError(HttpError.notFound);

    final future =  sut.auth(params);

    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw UnexpectedError if HttpClient returns 500', () async {
    httpClient.mockRequestError(HttpError.serverError);

    final future =  sut.auth(params);

    expect(future, throwsA(DomainError.unexpected));
  });
  test('Should throw InvalidCredentialsError if HttpClient  returns 401', () async {
    httpClient.mockRequestError(HttpError.unauthorized);

    final future =  sut.auth(params);

    expect(future, throwsA(DomainError.invalidCredentials));
  });

  test('Should return an Account if HttpClient returns 200', () async {
    final validData = mockvalidData();
    httpClient.mockRequest(validData);

    final account =  await sut.auth(params);

    expect(account.token, validData['accessToken']);
  });

test('Should throw Unexpected error if HttpClient returns 200 with invalid data', () async {
    httpClient.mockRequest({'invalid_key': 'invalid_value'});

    final future =  sut.auth(params);

    expect(future, throwsA(DomainError.unexpected));
  });
}