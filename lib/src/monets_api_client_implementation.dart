import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/io_client.dart';

import 'monets_api_client.dart';

import 'constants/http_exception.dart';
import 'constants/urls.dart';
import 'models/mon_ets_user.dart';
import 'package:http/http.dart' as http;

/// A Wrapper for all calls to MonETS API.
class MonETSAPIClient extends IMonETSAPIClient {
  static const String tag = "MonETSApi";
  static const String tagError = "$tag - Error";

  http.Client _httpClient;

  MonETSAPIClient({http.Client client}) {
    if (client == null) {
      final ioClient = HttpClient();
      _httpClient = IOClient(ioClient);
    } else {
      _httpClient = client;
    }
  }

  /// Authenticate the basic MonETS user
  ///
  /// Throws an [HttpException] if the MonETSApi return anything
  /// else than a 200 code
  @override
  Future<MonETSUser> authenticate(
      {@required String username, @required String password}) async {
    final response = await _httpClient.post(
        Uri.parse(Urls.authenticationMonETS),
        body: {"Username": username, "Password": password});

    // Log the http error and throw a exception
    if (response.statusCode != 200) {
      throw HttpException(
          message: response.body, prefix: tagError, code: response.statusCode);
    }
    return MonETSUser.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>);
  }
}
