import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ets_api_clients/src/models/api_response.dart';
import 'package:ets_api_clients/src/models/organizer.dart';
import 'package:ets_api_clients/src/constants/http_exception.dart';
import 'package:ets_api_clients/src/commands/command.dart';
import 'package:ets_api_clients/src/hello_api_client_implementation.dart';

class GetOrganizerCommand implements Command<Organizer?> {
  final HelloAPIClient client;
  final http.Client _httpClient;
  final String organizerId;

  GetOrganizerCommand(this.client, this._httpClient, this.organizerId);

  @override
  Future<Organizer?> execute() async {
    if (client.apiLink == null || client.apiLink!.isEmpty) {
      throw ArgumentError("_apiLink is null or empty");
    }
    final uri = Uri.https(client.apiLink!, '/api/organizers/$organizerId');
    final response = await _httpClient.get(uri);
    if (response.statusCode != 200) {
      throw HttpException(
        message: response.body,
        prefix: HelloAPIClient.tagError,
        code: response.statusCode,
      );
    }

    final json = jsonDecode(response.body);
    return ApiResponse<Organizer>.fromJson(json, Organizer.fromJson).data;
  }
}