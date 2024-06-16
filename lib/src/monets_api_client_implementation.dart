import 'dart:io';
import 'package:http/io_client.dart';

import 'monets_api_client.dart';

import 'commands/monets_api/authentificate_command.dart';
import 'models/mon_ets_user.dart';
import 'package:http/http.dart' as http;

/// A Wrapper for all calls to MonETS API.
class MonETSAPIClient implements IMonETSAPIClient {
  static const String tag = "MonETSApi";
  static const String tagError = "$tag - Error";

  final http.Client _httpClient;

  MonETSAPIClient({http.Client? client})
      : _httpClient = client ?? IOClient(HttpClient());


  @override
  Future<MonETSUser> authenticate({required String username, required String password}) {
    final command = AuthenticateCommand(this, _httpClient, username: username, password: password);
    return command.execute();
  }
}
