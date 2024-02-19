import 'dart:convert';
import 'dart:io';

import 'package:http/io_client.dart';

import 'constants/http_exception.dart';
import 'constants/urls.dart';

import 'hello_api_client.dart';

import 'models/news.dart';
import 'package:http/http.dart' as http;

/// A Wrapper for all calls to Hello API.
class HelloAPIClient implements IHelloAPIClient {
  static const String tag = "HelloApi";
  static const String tagError = "$tag - Error";

  final http.Client _httpClient;

  HelloAPIClient({http.Client? client})
      : _httpClient = client ?? IOClient(HttpClient());

  /// Call the Hello API to get the news
  /// [startDate] The start date of the news (optional)
  /// [endDate] The end date of the news (optional)
  /// [tags] The tags of the news (optional)
  /// [activityAreas] The activity areas of the news (optional)
  /// [pageNumber] The page number (default: 1)
  /// [pageSize] The page size (default: 10)
  @override
  Future<List<News>> getEvents(
      {DateTime? startDate,
      DateTime? endDate,
      List<String>? tags,
      List<String>? activityAreas,
      int pageNumber = 1,
      int pageSize = 10}) async {
    final query = {
      'startDate': startDate,
      'endDate': endDate,
      'tags': tags,
      'activityAreas': activityAreas,
      'pageNumber': pageNumber.toString(),
      'pageSize': pageSize.toString(),
    };
    final uri = Uri.https(Urls.helloNewsAPI, '/api/news', query);
    final response = await _httpClient.get(uri);

    // Log the http error and throw a exception
    if (response.statusCode != 200) {
      throw HttpException(
          message: response.body, prefix: tagError, code: response.statusCode);
    }

    final body = jsonDecode(response.body) as Map<String, dynamic>;
    final news = body['data'] as List<dynamic>;
    return news.map((e) => News.fromJson(e as Map<String, dynamic>)).toList();
  }
}
