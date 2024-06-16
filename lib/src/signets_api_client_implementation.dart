import 'dart:io';

import 'package:ets_api_clients/src/commands/signets_api/authentificate_command.dart';
import 'package:ets_api_clients/src/commands/signets_api/get_course_reviews_command.dart';
import 'package:ets_api_clients/src/commands/signets_api/get_course_summary_command.dart';
import 'package:ets_api_clients/src/commands/signets_api/get_courses_activities_command.dart';
import 'package:ets_api_clients/src/commands/signets_api/get_courses_command.dart';
import 'package:ets_api_clients/src/commands/signets_api/get_programs_command.dart';
import 'package:ets_api_clients/src/commands/signets_api/get_schedule_activities_command.dart';
import 'package:ets_api_clients/src/commands/signets_api/get_sessions_command.dart';
import 'package:ets_api_clients/src/commands/signets_api/get_student_info_command.dart';
import 'package:ets_api_clients/src/signets_api_client.dart';
import 'package:http/io_client.dart';
import 'package:xml/xml.dart';
import 'package:http/http.dart' as http;

import 'constants/urls.dart';
import 'services/soap_service.dart';
import 'constants/api_exception.dart';
import 'constants/signets_errors.dart';
import 'models/course_activity.dart';
import 'models/course.dart';
import 'models/course_review.dart';
import 'models/course_summary.dart';
import 'models/profile_student.dart';
import 'models/program.dart';
import 'models/schedule_activity.dart';
import 'models/session.dart';

/// A Wrapper for all calls to Signets API.
class SignetsAPIClient implements ISignetsAPIClient {
  static const String tag = "SignetsApi";
  static const String tagError = "$tag - Error";

  final http.Client _httpClient;

  SignetsAPIClient({http.Client? client})
      : _httpClient = client ?? IOClient(HttpClient());

  /// Expression to validate the format of a session short name (ex: A2020)
  final RegExp _sessionShortNameRegExp = RegExp("^([A-É-H][0-9]{4})");

  /// Expression to validate the format of a course (ex: MAT256-01)
  final RegExp _courseGroupRegExp = RegExp("^([A-Z]{3}[0-9]{3}-[0-9]{2})");

  /// Returns whether the user is logged in or not throught the SignetsAPI.
  @Deprecated(
      'This function is deprecated in favor of `MonETSAPIClient.authenticate()`')
  @override
  Future<bool> authenticate({required String username, required String password}) {
    final command = AuthenticateCommand(this, _httpClient, username: username, password: password);
    return command.execute();
  }

  /// Call the SignetsAPI to get the courses activities for the [session] for
  /// the student ([username]). By specifying [courseGroup] we can filter the
  /// results to get only the activities for this course.
  /// If the [startDate] and/or [endDate] are specified the results will contains
  /// all the activities between these dates
  @override
  Future<List<CourseActivity>> getCoursesActivities({
    required String username,
    required String password,
    String session = "",
    String courseGroup = "",
    DateTime? startDate,
    DateTime? endDate,
  }) {
    final command = GetCoursesActivitiesCommand(
      this,
      _httpClient,
      _sessionShortNameRegExp,
      _courseGroupRegExp,
      username: username,
      password: password,
      session: session,
      courseGroup: courseGroup,
      startDate: startDate,
      endDate: endDate,
    );
    return command.execute();
  }

  /// Call the SignetsAPI to get the courses activities for the [session] for
  /// the student ([username]).
  @override
  Future<List<ScheduleActivity>> getScheduleActivities({
    required String username,
    required String password,
    String session = "",
  }) {
    final command = GetScheduleActivitiesCommand(
      this,
      _httpClient,
      _sessionShortNameRegExp,
      _courseGroupRegExp,
      username: username,
      password: password,
      session: session,
    );
    return command.execute();
  }

  /// Call the SignetsAPI to get the courses of the student ([username]).
  @override
  Future<List<Course>> getCourses({
    required String username,
    required String password,
  }) {
    final command = GetCoursesCommand(this, _httpClient, username: username, password: password);
    return command.execute();
  }

  /// Call the SignetsAPI to get all the evaluations (exams) and the summary
  /// of [course] for the student ([username]).
  @override
  Future<CourseSummary> getCourseSummary({
    required String username,
    required String password,
    required Course course,
  }) {
    final command = GetCourseSummaryCommand(
      this,
      _httpClient,
      username: username,
      password: password,
      course: course,
    );
    return command.execute();
  }

  /// Call the SignetsAPI to get the list of all the [Session] for the student ([username]).
   @override
  Future<List<Session>> getSessions({
    required String username,
    required String password,
  }) {
    final command = GetSessionsCommand(this, _httpClient, username: username, password: password);
    return command.execute();
  }

  /// Call the SignetsAPI to get the [ProfileStudent] for the student.
  @override
  Future<ProfileStudent> getStudentInfo({
    required String username,
    required String password,
  }) {
    final command = GetStudentInfoCommand(this, _httpClient, username: username, password: password);
    return command.execute();
  }

  /// Call the SignetsAPI to get the list of all the [Program] for the student ([username]).
  @override
  Future<List<Program>> getPrograms({
    required String username,
    required String password,
  }) {
    final command = GetProgramsCommand(this, _httpClient, username: username, password: password);
    return command.execute();
  }

  /// Call the SignetsAPI to get the list of all [CourseReview] for the [session]
  /// of the student ([username]).
  @override
  Future<List<CourseReview>> getCourseReviews({
    required String username,
    required String password,
    Session? session,
  }) {
    final command = GetCourseReviewsCommand(
      this,
      _httpClient,
      username: username,
      password: password,
      session: session,
    );
    return command.execute();
  }
}
