import 'dart:convert';
import 'dart:io';

import 'package:ets_api_clients/src/models/api_response.dart';
import 'package:ets_api_clients/src/models/organizer.dart';
import 'package:ets_api_clients/src/models/paginated_news.dart';
import 'package:ets_api_clients/src/models/report.dart';
import 'package:http/io_client.dart';

import 'constants/http_exception.dart';
import 'constants/urls.dart';

import 'hello_api_client.dart';

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
  /// [organizerId] The organizer id (optional)
  /// [pageNumber] The page number (default: 1)
  /// [pageSize] The page size (default: 10)
  @override
  Future<PaginatedNews> getEvents(
      {DateTime? startDate,
      DateTime? endDate,
      List<String>? tags,
      List<String>? activityAreas,
      String? organizerId,
      int pageNumber = 1,
      int pageSize = 10}) async {
    final query = {
      'startDate': startDate,
      'endDate': endDate,
      'tags': tags,
      'activityAreas': activityAreas,
      'organizerId': organizerId,
      'pageNumber': pageNumber.toString(),
      'pageSize': pageSize.toString(),
    };

    if (query['startDate'] == null) {
      query.remove('startDate');
    }
    if (query['endDate'] == null) {
      query.remove('endDate');
    }
    if (query['tags'] == null) {
      query.remove('tags');
    }
    if (query['activityAreas'] == null) {
      query.remove('activityAreas');
    }
    if (query['organizerId'] == null) {
      query.remove('organizerId');
    }

    final uri = Uri.https(Urls.helloNewsAPI, '/api/events');
    final response = await _httpClient.get(uri.replace(queryParameters: query));

    // Log the http error and throw a exception
    if (response.statusCode != 200) {
      throw HttpException(
          message: response.body, prefix: tagError, code: response.statusCode);
    }

    return PaginatedNews.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>);
  }

  /// Call the Hello API to get the organizer
  /// [organizerId] The organizer id
  @override
  Future<Organizer?> getOrganizer(String organizerId) async {
    final uri =
        Uri.https(Urls.helloNewsAPI, '/api/moderator/organizer/$organizerId');
    final response = await _httpClient.get(uri);

    // Log the http error and throw a exception
    if (response.statusCode != 200) {
      throw HttpException(
          message: response.body, prefix: tagError, code: response.statusCode);
    }

    final json = jsonDecode(response.body);

    return ApiResponse<Organizer>.fromJson(json, Organizer.fromJson).data;
  }

  /// Call the Hello API to report a news
  /// [newsId] The news id
  /// [report] The report
  @override
  Future<bool> reportNews(String newsId, Report report) async {
    final uri = Uri.https(Urls.helloNewsAPI, '/api/events/$newsId/reports');
    final response = await _httpClient.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'reason': report.reason,
        'category': report.category
      }),
    );

    // Log the http error and throw a exception
    if (response.statusCode != 200) {
      throw HttpException(
          message: response.body, prefix: tagError, code: response.statusCode);
    }

    return true;
  }
}
