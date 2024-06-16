import 'package:ets_api_clients/src/commands/command.dart';
import 'package:ets_api_clients/src/constants/urls.dart';
import 'package:ets_api_clients/src/models/course_review.dart';
import 'package:ets_api_clients/src/models/session.dart';
import 'package:ets_api_clients/src/services/soap_service.dart';
import 'package:ets_api_clients/src/signets_api_client_implementation.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart';

/// Call the SignetsAPI to get the list of all [CourseReview] for the [session]
/// of the student ([username]).
class GetCourseReviewsCommand implements Command<List<CourseReview>> {
  final SignetsAPIClient client;
  final http.Client _httpClient;
  final String username;
  final String password;
  final Session? session;

  GetCourseReviewsCommand(
    this.client,
    this._httpClient, {
    required this.username,
    required this.password,
    this.session,
  });

  @override
  Future<List<CourseReview>> execute() async {
    // Generate initial soap envelope
    final body = SoapService.buildBasicSOAPBody(
            Urls.readCourseReviewOperation, username, password)
        .buildDocument();

    final operationContent = XmlBuilder();

    operationContent.element("pSession", nest: () {
      operationContent.text(session!.shortName);
    });

    body
        .findAllElements(Urls.readCourseReviewOperation,
            namespace: Urls.signetsOperationBase)
        .first
        .children
        .add(operationContent.buildFragment());

    final responseBody = await SoapService.sendSOAPRequest(
        _httpClient, body, Urls.readCourseReviewOperation);

    /// Build and return the list of Program
    return responseBody
        .findAllElements("EvaluationCours")
        .map((node) => CourseReview.fromXmlNode(node))
        .toList();
  }
}
