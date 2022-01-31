import 'dart:convert';

import 'constants/http_exception.dart';
import 'constants/urls.dart';
import 'models/mon_ets_user.dart';
import 'package:http/http.dart' as http;

/// A Wrapper for all calls to MonETS API.
class MonETSAPIClient {
  static const String tag = "MonETSApi";
  static const String tagError = "$tag - Error";

  late String _username;
  late String _password;

  MonETSAPIClient(String username, String password) {
    _username = username;
    _password = password;
  }

  /// Authenticate the basic MonETS user
  ///
  /// Throws an [HttpException] if the MonETSApi return anything
  /// else than a 200 code
  Future<MonETSUser> authenticate() async {
    final response = await http.post(Uri.parse(Urls.authenticationMonETS),
        body: {"Username": _username, "Password": _password});

    // Log the http error and throw a exception
    if (response.statusCode != 200) {
      throw HttpException(
          message: response.body, prefix: tagError, code: response.statusCode);
    }
    return MonETSUser.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>);
  }
}
