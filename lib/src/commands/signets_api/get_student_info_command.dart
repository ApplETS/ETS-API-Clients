import 'package:ets_api_clients/src/commands/command.dart';
import 'package:ets_api_clients/src/constants/urls.dart';
import 'package:ets_api_clients/src/models/profile_student.dart';
import 'package:ets_api_clients/src/services/soap_service.dart';
import 'package:ets_api_clients/src/signets_api_client_implementation.dart';
import 'package:http/http.dart' as http;

/// Call the SignetsAPI to get the [ProfileStudent] for the student.
class GetStudentInfoCommand implements Command<ProfileStudent> {
  final SignetsAPIClient client;
  final http.Client _httpClient;
  final String username;
  final String password;

  GetStudentInfoCommand(this.client, this._httpClient,
      {required this.username, required this.password});

  @override
  Future<ProfileStudent> execute() async {
    // Generate initial soap envelope
    final body = SoapService.buildBasicSOAPBody(
            Urls.infoStudentOperation, username, password)
        .buildDocument();

    final responseBody = await SoapService.sendSOAPRequest(
        _httpClient, body, Urls.infoStudentOperation);

    // Build and return the info
    return ProfileStudent.fromXmlNode(responseBody);
  }
}
