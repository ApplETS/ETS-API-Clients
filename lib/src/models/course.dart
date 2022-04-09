// FLUTTER / DART / THIRD-PARTIES
import 'package:xml/xml.dart';

import 'course_review.dart';
import 'course_summary.dart';

// MODELS

/// Data-class that represent a course
class Course {
  /// Course acronym (ex: LOG430)
  final String acronym;

  /// Title of the course (ex: Chimie et matériaux)
  final String title;

  /// Course group, on which group the student is registered
  final String group;

  /// Session short name during which the course is given (ex: H2020)
  final String session;

  /// Code number of the program of which the course is a part of
  final String programCode;

  /// Final grade of the course (ex: A+, C, ...) if the course doesn't
  /// have a the grade yet the variable will be null.
  final String? grade;

  /// Number of credits of the course
  final int numberOfCredits;

  /// Current mark, score... of the student for this course.
  CourseSummary? summary;

  /// Information about when the course will be evaluated by the student.
  CourseReview? review;

  /// Get the teacher name if available
  String? get teacherName => review?.teacherName;

  /// Determine if we are currently in the review period for this course.
  bool get inReviewPeriod {
    if (review == null) {
      return false;
    }

    final now = DateTime.now();

    return now.isAfter(review!.startAt) && now.isBefore(review!.endAt);
  }

  /// Determine if the review of this course is completed.
  bool? get reviewCompleted {
    if (review == null) {
      return true;
    }
    return review!.isCompleted;
  }

  Course(
      {required this.acronym,
      required this.title,
      required this.group,
      required this.session,
      required this.programCode,
      required this.numberOfCredits,
      this.grade,
      this.summary,
      this.review});

  /// Used to create a new [Course] instance from a [XMLElement].
  factory Course.fromXmlNode(XmlElement node) => Course(
      acronym: node.getElement('sigle')!.innerText,
      title: node.getElement('titreCours')!.innerText,
      group: node.getElement('groupe')!.innerText,
      session: node.getElement('session')!.innerText,
      programCode: node.getElement('programmeEtudes')!.innerText,
      numberOfCredits: int.parse(node.getElement('nbCredits')!.innerText),
      grade: node.getElement('cote')!.innerText.isEmpty
          ? null
          : node.getElement('cote')!.innerText);

  /// Used to create [Course] instance from a JSON file
  factory Course.fromJson(Map<String, dynamic> map) => Course(
      acronym: map['acronym'] as String,
      title: map['title'] as String,
      group: map['group'] as String,
      session: map['session'] as String,
      programCode: map['programCode'] as String,
      numberOfCredits: map['numberOfCredits'] as int,
      grade: map['grade'] as String?,
      summary: map["summary"] != null
          ? CourseSummary.fromJson(map["summary"] as Map<String, dynamic>)
          : null,
      review: map["review"] != null
          ? CourseReview.fromJson(map["review"] as Map<String, dynamic>)
          : null);

  Map<String, dynamic> toJson() => {
        'acronym': acronym,
        'title': title,
        'group': group,
        'session': session,
        'programCode': programCode,
        'numberOfCredits': numberOfCredits,
        'grade': grade,
        'summary': summary,
        'review': review
      };

  @override
  String toString() {
    return 'Course{'
        'acronym: $acronym, '
        'title: $title, '
        'group: $group, '
        'session: $session, '
        'programCode: $programCode, '
        'grade: $grade, '
        'numberOfCredits: $numberOfCredits, '
        'summary: $summary, '
        'review: $review}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Course &&
          runtimeType == other.runtimeType &&
          acronym == other.acronym &&
          title == other.title &&
          group == other.group &&
          session == other.session &&
          programCode == other.programCode &&
          grade == other.grade &&
          numberOfCredits == other.numberOfCredits &&
          summary == other.summary &&
          review == other.review;

  @override
  int get hashCode =>
      acronym.hashCode ^
      title.hashCode ^
      group.hashCode ^
      session.hashCode ^
      programCode.hashCode ^
      grade.hashCode ^
      numberOfCredits.hashCode ^
      summary.hashCode ^
      review.hashCode;
}
