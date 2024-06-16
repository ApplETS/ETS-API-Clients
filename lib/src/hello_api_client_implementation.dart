import 'dart:io';

import 'package:ets_api_clients/src/models/organizer.dart';
import 'package:ets_api_clients/src/models/paginated_news.dart';
import 'package:ets_api_clients/src/models/report.dart';
import 'package:http/io_client.dart';

import 'hello_api_client.dart';
import 'package:http/http.dart' as http;

import 'commands/hello_api/get_events_command.dart';
import 'commands/hello_api/get_organizer_command.dart';
import 'commands/hello_api/report_news_command.dart';

/// A Wrapper for all calls to Hello API.
class HelloAPIClient implements IHelloAPIClient {
  static const String tag = "HelloApi";
  static const String tagError = "$tag - Error";

  final http.Client _httpClient;

  @override
  String? apiLink;

  HelloAPIClient({http.Client? client})
      : _httpClient = client ?? IOClient(HttpClient());

  /// Call the Hello API to get the news
  @override
  Future<PaginatedNews> getEvents({
    DateTime? startDate,
    DateTime? endDate,
    List<String>? tags,
    List<String>? activityAreas,
    String? organizerId,
    String? title,
    int pageNumber = 1,
    int pageSize = 10,
  }) {
    final command = GetEventsCommand(
      this,
      _httpClient,
      startDate: startDate,
      endDate: endDate,
      tags: tags,
      activityAreas: activityAreas,
      organizerId: organizerId,
      title: title,
      pageNumber: pageNumber,
      pageSize: pageSize,
    );
    return command.execute();
  }

  /// Call the Hello API to get the organizer
  @override
  Future<Organizer?> getOrganizer(String organizerId) {
    final command = GetOrganizerCommand(this, _httpClient, organizerId);
    return command.execute();
  }

  /// Call the Hello API to report a news
  @override
  Future<bool> reportNews(String newsId, Report report) {
    final command = ReportNewsCommand(this, _httpClient, newsId, report);
    return command.execute();
  }
}