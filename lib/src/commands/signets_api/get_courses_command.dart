import 'package:ets_api_clients/src/commands/command.dart';
import 'package:ets_api_clients/src/constants/urls.dart';
import 'package:ets_api_clients/src/models/course.dart';
import 'package:ets_api_clients/src/models/schedule_activity.dart';
import 'package:ets_api_clients/src/services/soap_service.dart';
import 'package:ets_api_clients/src/signets_api_client_implementation.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart';

class GetCoursesCommand implements Command<List<Course>> {
  final SignetsAPIClient client;
  final http.Client _httpClient;
  final String username;
  final String password;

  GetCoursesCommand(this.client, this._httpClient, {required this.username, required this.password});

  @override
  Future<List<Course>> execute() async {
    // Generate initial soap envelope
    final body = SoapService.buildBasicSOAPBody(
            Urls.listCourseOperation, username, password)
        .buildDocument();

    final responseBody = await SoapService.sendSOAPRequest(
        _httpClient, body, Urls.listCourseOperation);

    return responseBody
        .findAllElements("Cours")
        .map((node) => Course.fromXmlNode(node))
        .toList();
  }
}