import 'dart:convert';
import 'package:http/http.dart';

import '../../data/http/http.dart';

class HttpAdpater implements HttpClient {
  final Client client;

  HttpAdpater(this.client);

  @override
  Future<dynamic> request({required String url, required String method, Map? body}) async {

    final headers = {
      'content-type': 'applicatino/json',
      'accept': 'applicatino/json',
    };

    final jsonBody = body != null ? jsonEncode(body) : null;
    final Uri uri = Uri.parse(url);
    var response = Response('', 500);

    try {
      if (method == 'post') {
        response = await client.post(uri, headers: headers, body: jsonBody);
      }
    } catch (error) {
      throw HttpError.serverError;
    }

    return _handleResponse(response);
  }

  dynamic _handleResponse(Response response) {
    if (response.statusCode == 200) {
      return response.body.isEmpty ? null : jsonDecode(response.body);
    } else if (response.statusCode == 204) {
      return null;
    } else if (response.statusCode == 400) {
      throw HttpError.badRequest;
    } else if (response.statusCode == 401) {
      throw HttpError.unauthorized;
    } else if (response.statusCode == 403) {
      throw HttpError.forbindden;
    } else if (response.statusCode == 404) {
      throw HttpError.notFound;
    } else {
      throw HttpError.serverError;
    }
  }
}
