import 'package:faker/faker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import '../mocks/mocks.dart';

import 'package:fordev/data/http/http.dart';
import 'package:fordev/infra/http/http.dart';



void main() {
  late HttpAdpater sut;
  late ClientSpy client;
  late String url;

  setUp(() {
    client = ClientSpy();
    sut = HttpAdpater(client);
  });

  setUpAll(() {
    url = faker.internet.httpUrl();
    registerFallbackValue(Uri.parse(url));
  });

  group('shared', () {
    test('Should throw ServerError if invalid method is provided', () async {
      final futere = sut.request(url: url, method: 'invalid_method');

      expect(futere, throwsA(HttpError.serverError));
    });

  });
  group('post', () {

    test('Should call post with correct values', () async {
      await sut.request(url: url, method: 'post', body: {'any_key': 'any_value'});

      verify(() => client.post(
        Uri.parse(url),
        headers: {
          'content-type': 'applicatino/json',
          'accept': 'applicatino/json',
        },
        body: '{"any_key":"any_value"}'
      ));
    });

    test('Should call post without body', () async {
      await sut.request(url: url, method: 'post', body: null);

      verify(() => client.post(
        any(),
        headers: any(named: 'headers')
      ));
    });

    test('Should return data if post returns 200', () async {
      final response = await sut.request(url: url, method: 'post');

      expect(response, {'any_key': 'any_value'});
    });

    test('Should return null if post returns 200 with no data', () async {
      client.mockPost(200, body: '');
      final response = await sut.request(url: url, method: 'post');

      expect(response, null);
    });

   test('Should return null if post returns 204 with data', () async {
      client.mockPost(204);
      final response = await sut.request(url: url, method: 'post');

      expect(response, null);
    });

   test('Should return BadRequest if post returns 400', () async {
      client.mockPost(400, body: '');
      final future = sut.request(url: url, method: 'post');

      expect(future, throwsA(HttpError.badRequest));
    });

   test('Should return Unauthorized if post returns 401', () async {
      client.mockPost(401);
      final future = sut.request(url: url, method: 'post');

      expect(future, throwsA(HttpError.unauthorized));
    });

   test('Should return Forbinden if post returns 403', () async {
      client.mockPost(403);
      final future = sut.request(url: url, method: 'post');

      expect(future, throwsA(HttpError.forbindden));
    });


   test('Should return Not Found if post returns 404', () async {
      client.mockPost(404);
      final future = sut.request(url: url, method: 'post');

      expect(future, throwsA(HttpError.notFound));
    });

   test('Should return ServerError if post returns 500', () async {
      client.mockPost(500);
      final future = sut.request(url: url, method: 'post');

      expect(future, throwsA(HttpError.serverError));
    });


   test('Should return ServerError if post throws', () async {
      client.mockPostError();
      final future = sut.request(url: url, method: 'post');

      expect(future, throwsA(HttpError.serverError));
    });

  });
}