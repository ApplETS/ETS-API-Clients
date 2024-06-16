import 'package:ets_api_clients/src/commands/command.dart';
import 'package:ets_api_clients/src/constants/urls.dart';
import 'package:ets_api_clients/src/models/program.dart';
import 'package:ets_api_clients/src/models/schedule_activity.dart';
import 'package:ets_api_clients/src/services/soap_service.dart';
import 'package:ets_api_clients/src/signets_api_client_implementation.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart';

class GetProgramsCommand implements Command<List<Program>> {
  final SignetsAPIClient client;
  final http.Client _httpClient;
  final String username;
  final String password;

  GetProgramsCommand(this.client, this._httpClient, {required this.username, required this.password});

  @override
  Future<List<Program>> execute() async {
    // Generate initial soap envelope
    final body = SoapService.buildBasicSOAPBody(
            Urls.listProgramsOperation, username, password)
        .buildDocument();

    final responseBody = await SoapService.sendSOAPRequest(
        _httpClient, body, Urls.listProgramsOperation);

    /// Build and return the list of Program
    return responseBody
        .findAllElements("Programme")
        .map((node) => Program.fromXmlNode(node))
        .toList();
  }
}