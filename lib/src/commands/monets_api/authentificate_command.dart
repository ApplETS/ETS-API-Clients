import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:ets_api_clients/src/commands/command.dart';
import 'package:ets_api_clients/src/constants/urls.dart';
import 'package:ets_api_clients/src/monets_api_client_implementation.dart';
import 'package:ets_api_clients/exceptions.dart';
import 'package:ets_api_clients/models.dart';

/// Authenticate the basic MonETS user
///
/// Throws an [HttpException] if the MonETSApi return anything
/// else than a 200 code
class AuthenticateCommand implements Command<MonETSUser> {
  final MonETSAPIClient client;
  final http.Client _httpClient;
  final String username;
  final String password;

  AuthenticateCommand(this.client, this._httpClient,
      {required this.username, required this.password});

  @override
  Future<MonETSUser> execute() async {
    final response = await _httpClient.post(
      Uri.parse(Urls.authenticationMonETS),
      body: {"Username": username, "Password": password},
    );

    // Log the http error and throw a exception
    if (response.statusCode != 200) {
      throw HttpException(
        message: response.body,
        prefix: MonETSAPIClient.tagError,
        code: response.statusCode,
      );
    }

    return MonETSUser.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>);
  }
}
