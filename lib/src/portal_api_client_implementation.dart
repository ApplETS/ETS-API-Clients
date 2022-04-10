import 'dart:convert';
import 'dart:io';
import 'package:http/io_client.dart';

import 'portal_api_client.dart';

import 'constants/http_exception.dart';
import 'constants/urls.dart';
import 'models/whats_new.dart';
import 'package:http/http.dart' as http;

/// A Wrapper for all calls to Signets API.
class PortalAPIClient implements IPortalAPIClient {
  static const String tag = "PortalApi";
  static const String tagError = "$tag - Error";

  final http.Client _httpClient;

  final String _url;

  final String _projectId;

  PortalAPIClient(String projectId, {http.Client? client, String? url})
      : _projectId = projectId,
        _httpClient = client ?? IOClient(HttpClient()),
        _url = url ?? Urls.portalAPI;

  /// Call the Portal API to get the list of all the [WhatsNew] for the app user
  /// that requested it
  @override
  Future<WhatsNew> getWhatsNewForVersion({required String version}) async {
    final String url =
        _url + '/api/projects/' + _projectId + '/whatsnew/' + version;
    final http.Response response = await _httpClient.get(Uri.parse(url));

    // Log the http error and throw a exception
    if (response.statusCode != 200) {
      throw HttpException(
          message: response.body, prefix: tagError, code: response.statusCode);
    }

    return WhatsNew.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  }
}
