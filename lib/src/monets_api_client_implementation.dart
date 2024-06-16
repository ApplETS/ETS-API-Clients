import 'dart:io';
import 'package:http/io_client.dart';

import 'package:ets_api_clients/src/monets_api_client.dart';

import 'package:ets_api_clients/src/commands/monets_api/authentificate_command.dart';
import 'package:ets_api_clients/src/models/mon_ets_user.dart';
import 'package:http/http.dart' as http;

/// A Wrapper for all calls to MonETS API.
class MonETSAPIClient implements IMonETSAPIClient {
  static const String tag = "MonETSApi";
  static const String tagError = "$tag - Error";

  final http.Client _httpClient;

  MonETSAPIClient({http.Client? client})
      : _httpClient = client ?? IOClient(HttpClient());

  /// Authenticate the basic MonETS user
  ///
  /// Throws an [HttpException] if the MonETSApi return anything
  /// else than a 200 code
  @override
  Future<MonETSUser> authenticate(
      {required String username, required String password}) {
    final command = AuthenticateCommand(this, _httpClient,
        username: username, password: password);
    return command.execute();
  }
}
