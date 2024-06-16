import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ets_api_clients/src/models/report.dart';
import 'package:ets_api_clients/src/constants/http_exception.dart';
import 'package:ets_api_clients/src/commands/command.dart';
import 'package:ets_api_clients/src/hello_api_client_implementation.dart';

class ReportNewsCommand implements Command<bool> {
  final HelloAPIClient client;
  final http.Client _httpClient;
  final String newsId;
  final Report report;

  ReportNewsCommand(this.client, this._httpClient, this.newsId, this.report);

  @override
  Future<bool> execute() async {
    if (client.apiLink == null || client.apiLink!.isEmpty) {
      throw ArgumentError("_apiLink is null or empty");
    }
    final uri = Uri.https(client.apiLink!, '/api/reports/$newsId');
    final response = await _httpClient.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'reason': report.reason,
        'category': report.category,
      }),
    );

    if (response.statusCode != 200) {
      throw HttpException(
        message: response.body,
        prefix: HelloAPIClient.tagError,
        code: response.statusCode,
      );
    }

    return true;
  }
}