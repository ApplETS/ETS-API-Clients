import 'models/course_activity.dart';
import 'models/course.dart';
import 'models/course_evaluation.dart';
import 'models/course_summary.dart';
import 'models/profile_student.dart';
import 'models/program.dart';
import 'models/schedule_activity.dart';
import 'models/session.dart';

/// A Wrapper for all calls to Signets API.
abstract class ISignetsAPIClient {
  /// Returns whether the user is logged in or not throught the SignetsAPI.
  @Deprecated(
      'This function is deprecated in favor of `MonETSAPIClient.authenticate()`')
  Future<bool> authenticate(
      {required String username, required String password});

  /// Call the SignetsAPI to get the courses activities for the [session] for
  /// the student ([username]). By specifying [courseGroup] we can filter the
  /// results to get only the activities for this course.
  /// If the [startDate] and/or [endDate] are specified the results will contains
  /// all the activities between these dates
  Future<List<CourseActivity>> getCoursesActivities(
      {required String username,
      required String password,
      String session = "",
      String courseGroup = "",
      DateTime? startDate,
      DateTime? endDate});

  /// Call the SignetsAPI to get the courses activities for the [session] for
  /// the student ([username]).
  Future<List<ScheduleActivity>> getScheduleActivities(
      {required String username,
      required String password,
      String session = ""});

  /// Call the SignetsAPI to get the courses of the student ([username]).
  Future<List<Course>> getCourses(
      {required String username, required String password});

  /// Call the SignetsAPI to get all the evaluations (exams) and the summary
  /// of [course] for the student ([username]).
  Future<CourseSummary> getCourseSummary(
      {required String username,
      required String password,
      required Course course});

  /// Call the SignetsAPI to get the list of all the [Session] for the student ([username]).
  Future<List<Session>> getSessions(
      {required String username, required String password});

  /// Call the SignetsAPI to get the [ProfileStudent] for the student.
  Future<ProfileStudent> getStudentInfo(
      {required String username, required String password});

  /// Call the SignetsAPI to get the list of all the [Program] for the student ([username]).
  Future<List<Program>> getPrograms(
      {required String username, required String password});

  /// Call the SignetsAPI to get the list of all [CourseEvaluation] for the [session]
  /// of the student ([username]).
  Future<List<CourseEvaluation>> getCoursesEvaluation(
      {required String username,
      required String password,
      required Session session});
}
