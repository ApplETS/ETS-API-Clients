import 'package:signets_api_client/src/constants/urls.dart';
import 'package:signets_api_client/src/services/soap_service.dart';
import 'package:xml/xml.dart';

import 'constants/api_exception.dart';
import 'constants/signets_errors.dart';
import 'models/course_activity.dart';
import 'models/course.dart';
import 'models/course_evaluation.dart';
import 'models/course_summary.dart';
import 'models/profile_student.dart';
import 'models/program.dart';
import 'models/schedule_activity.dart';
import 'models/session.dart';

/// A Wrapper for all calls to Signets API.
class SignetsAPIClient {
  static const String tag = "SignetsApi";
  static const String tagError = "$tag - Error";

  late String _username;
  late String _password;

  /// Expression to validate the format of a session short name (ex: A2020)
  final RegExp _sessionShortNameRegExp = RegExp("^([A-É-H][0-9]{4})");

  /// Expression to validate the format of a course (ex: MAT256-01)
  final RegExp _courseGroupRegExp = RegExp("^([A-Z]{3}[0-9]{3}-[0-9]{2})");

  SignetsAPIClient(String username, String password) {
    _username = username;
    _password = password;
  }

  /// Returns whether the user is logged in or not throught the SignetsAPI.
  @Deprecated(
      'This function is deprecated in favor of `MonETSAPIClient.authenticate()`')
  Future<bool> authenticate() async {
    // Generate initial soap envelope
    final body = SoapService.buildBasicSOAPBody(
            Urls.donneesAuthentificationValides, _username, _password)
        .buildDocument();
    final responseBody = await SoapService.sendSOAPRequest(
        body, Urls.donneesAuthentificationValides);

    /// Build and return the authentication status
    return responseBody.innerText == "true";
  }

  /// Call the SignetsAPI to get the courses activities for the [session] for
  /// the student ([username]). By specifying [courseGroup] we can filter the
  /// results to get only the activities for this course.
  /// If the [startDate] and/or [endDate] are specified the results will contains
  /// all the activities between these dates
  Future<List<CourseActivity>> getCoursesActivities(
      {String session = "",
      String courseGroup = "",
      DateTime? startDate,
      DateTime? endDate}) async {
    // Validate the format of parameters
    if (!_sessionShortNameRegExp.hasMatch(session)) {
      throw FormatException("Session $session isn't a correctly formatted");
    }
    if (courseGroup.isNotEmpty && !_courseGroupRegExp.hasMatch(courseGroup)) {
      throw FormatException(
          "CourseGroup $courseGroup isn't a correctly formatted");
    }
    if (startDate != null && endDate != null && startDate.isAfter(endDate)) {
      throw ArgumentError("The startDate can't be after endDate.");
    }

    // Generate initial soap envelope
    final body = SoapService.buildBasicSOAPBody(
            Urls.listClassScheduleOperation, _username, _password)
        .buildDocument();
    final operationContent = XmlBuilder();

    // Add the content needed by the operation
    operationContent.element("pSession", nest: () {
      operationContent.text(session);
    });
    operationContent.element("pCoursGroupe", nest: () {
      operationContent.text(courseGroup);
    });

    operationContent.element("pDateDebut", nest: () {
      operationContent.text(startDate == null
          ? ""
          : "${startDate.year}-${startDate.month}-${startDate.day}");
    });
    operationContent.element("pDateFin", nest: () {
      operationContent.text(endDate == null
          ? ""
          : "${endDate.year}-${endDate.month}-${endDate.day}");
    });

    // Add the parameters needed inside the request.
    body
        .findAllElements(Urls.listClassScheduleOperation,
            namespace: Urls.signetsOperationBase)
        .first
        .children
        .add(operationContent.buildFragment());

    final responseBody = await SoapService.sendSOAPRequest(
        body, Urls.listClassScheduleOperation);

    /// Build and return the list of CourseActivity
    return responseBody
        .findAllElements("Seances")
        .map((node) => CourseActivity.fromXmlNode(node))
        .toList();
  }

  /// Call the SignetsAPI to get the courses activities for the [session] for
  /// the student ([username]).
  Future<List<ScheduleActivity>> getScheduleActivities(
      {String session = ""}) async {
    if (!_sessionShortNameRegExp.hasMatch(session)) {
      throw FormatException("Session $session isn't correctly formatted");
    }

    // Generate initial soap envelope
    final body = SoapService.buildBasicSOAPBody(
            Urls.listeHoraireEtProf, _username, _password)
        .buildDocument();
    final operationContent = XmlBuilder();

    // Add the content needed by the operation
    operationContent.element("pSession", nest: () {
      operationContent.text(session);
    });

    // Add the parameters needed inside the request.
    body
        .findAllElements(Urls.listeHoraireEtProf,
            namespace: Urls.signetsOperationBase)
        .first
        .children
        .add(operationContent.buildFragment());

    final responseBody =
        await SoapService.sendSOAPRequest(body, Urls.listeHoraireEtProf);

    /// Build and return the list of CourseActivity
    return responseBody
        .findAllElements("HoraireActivite")
        .map((node) => ScheduleActivity.fromXmlNode(node))
        .toList();
  }

  /// Call the SignetsAPI to get the courses of the student ([username]).
  Future<List<Course>> getCourses() async {
    // Generate initial soap envelope
    final body = SoapService.buildBasicSOAPBody(
            Urls.listCourseOperation, _username, _password)
        .buildDocument();

    final responseBody =
        await SoapService.sendSOAPRequest(body, Urls.listCourseOperation);

    return responseBody
        .findAllElements("Cours")
        .map((node) => Course.fromXmlNode(node))
        .toList();
  }

  /// Call the SignetsAPI to get all the evaluations (exams) and the summary
  /// of [course] for the student ([username]).
  Future<CourseSummary> getCourseSummary({required Course course}) async {
    // Generate initial soap envelope
    final body = SoapService.buildBasicSOAPBody(
            Urls.listEvaluationsOperation, _username, _password)
        .buildDocument();
    final operationContent = XmlBuilder();

    // Add the content needed by the operation
    operationContent.element("pSigle", nest: () {
      operationContent.text(course.acronym!);
    });
    operationContent.element("pGroupe", nest: () {
      operationContent.text(course.group!);
    });
    operationContent.element("pSession", nest: () {
      operationContent.text(course.session!);
    });

    body
        .findAllElements(Urls.listEvaluationsOperation,
            namespace: Urls.signetsOperationBase)
        .first
        .children
        .add(operationContent.buildFragment());

    final responseBody =
        await SoapService.sendSOAPRequest(body, Urls.listEvaluationsOperation);
    var errorTag = responseBody.getElement(SignetsError.signetsErrorSoapTag);
    if (errorTag != null &&
            errorTag.innerText.contains(SignetsError.gradesNotAvailable) ||
        responseBody.findAllElements('ElementEvaluation').isEmpty) {
      throw const ApiException(
          prefix: tag,
          message: "No grades available",
          errorCode: SignetsError.gradesEmpty);
    }

    return CourseSummary.fromXmlNode(responseBody);
  }

  /// Call the SignetsAPI to get the list of all the [Session] for the student ([username]).
  Future<List<Session>> getSessions() async {
    // Generate initial soap envelope
    final body = SoapService.buildBasicSOAPBody(
            Urls.listSessionsOperation, _username, _password)
        .buildDocument();

    final responseBody =
        await SoapService.sendSOAPRequest(body, Urls.listSessionsOperation);

    /// Build and return the list of Session
    return responseBody
        .findAllElements("Trimestre")
        .map((node) => Session.fromXmlNode(node))
        .toList();
  }

  /// Call the SignetsAPI to get the [ProfileStudent] for the student.
  Future<ProfileStudent> getStudentInfo() async {
    // Generate initial soap envelope
    final body = SoapService.buildBasicSOAPBody(
            Urls.infoStudentOperation, _username, _password)
        .buildDocument();

    final responseBody =
        await SoapService.sendSOAPRequest(body, Urls.infoStudentOperation);

    // Build and return the info
    return ProfileStudent.fromXmlNode(responseBody);
  }

  /// Call the SignetsAPI to get the list of all the [Program] for the student ([username]).
  Future<List<Program>> getPrograms() async {
    // Generate initial soap envelope
    final body = SoapService.buildBasicSOAPBody(
            Urls.listProgramsOperation, _username, _password)
        .buildDocument();

    final responseBody =
        await SoapService.sendSOAPRequest(body, Urls.listProgramsOperation);

    /// Build and return the list of Program
    return responseBody
        .findAllElements("Programme")
        .map((node) => Program.fromXmlNode(node))
        .toList();
  }

  /// Call the SignetsAPI to get the list of all [CourseEvaluation] for the [session]
  /// of the student ([username]).
  Future<List<CourseEvaluation>> getCoursesEvaluation(
      {required Session session}) async {
    // Generate initial soap envelope
    final body = SoapService.buildBasicSOAPBody(
            Urls.readCourseEvaluationOperation, _username, _password)
        .buildDocument();

    final operationContent = XmlBuilder();

    operationContent.element("pSession", nest: () {
      operationContent.text(session.shortName!);
    });

    body
        .findAllElements(Urls.readCourseEvaluationOperation,
            namespace: Urls.signetsOperationBase)
        .first
        .children
        .add(operationContent.buildFragment());

    final responseBody = await SoapService.sendSOAPRequest(
        body, Urls.readCourseEvaluationOperation);

    /// Build and return the list of Program
    return responseBody
        .findAllElements("EvaluationCours")
        .map((node) => CourseEvaluation.fromXmlNode(node))
        .toList();
  }
}
