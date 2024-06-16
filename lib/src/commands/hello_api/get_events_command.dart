import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ets_api_clients/src/models/paginated_news.dart';
import 'package:ets_api_clients/src/constants/http_exception.dart';
import 'package:ets_api_clients/src/commands/command.dart';
import 'package:ets_api_clients/src/hello_api_client_implementation.dart';

class GetEventsCommand implements Command<PaginatedNews> {
  final HelloAPIClient client;
  final http.Client _httpClient;
  final DateTime? startDate;
  final DateTime? endDate;
  final List<String>? tags;
  final List<String>? activityAreas;
  final String? organizerId;
  final String? title;
  final int pageNumber;
  final int pageSize;

  GetEventsCommand(
    this.client, 
    this._httpClient, {
    this.startDate,
    this.endDate,
    this.tags,
    this.activityAreas,
    this.organizerId,
    this.title,
    this.pageNumber = 1,
    this.pageSize = 10,
  });

  @override
  Future<PaginatedNews> execute() async {
    if (client.apiLink == null || client.apiLink!.isEmpty) {
      throw ArgumentError("_apiLink is null or empty");
    }
    final query = {
      'pageNumber': pageNumber.toString(),
      'pageSize': pageSize.toString(),
    };

    if (startDate != null) {
      query['startDate'] = startDate!.toUtc().toIso8601String();
    }
    if (endDate != null) {
      query['endDate'] = endDate!.toUtc().toIso8601String();
    }
    if (tags != null) {
      query['tags'] = tags.toString();
    }
    if (activityAreas != null) {
      query['activityAreas'] = activityAreas.toString();
    }
    if (organizerId != null) {
      query['organizerId'] = organizerId!;
    }
    if (title != null) {
      query['title'] = title!;
    }

    final uri = Uri.https(client.apiLink!, '/api/events');
    final response = await _httpClient.get(uri.replace(queryParameters: query));

    if (response.statusCode != 200) {
      throw HttpException(
        message: response.body,
        prefix: HelloAPIClient.tagError,
        code: response.statusCode,
      );
    }

    return PaginatedNews.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  }
}