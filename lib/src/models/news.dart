// FLUTTER / DART / THIRD-PARTIES
import 'news_user.dart';

/// Data-class that represent an hello-based news
class News {
  /// News unique Id
  final String id;

  /// A news title
  final String title;

  /// The news content
  final String content;

  /// The imageUrl of the news
  final String? imageThumbnail;

  /// The current state of the news
  final int state;

  /// The date that the news was created at
  final DateTime publicationDate;

  /// Date when the event start
  final DateTime eventStartDate;

  /// Date when the event end
  final DateTime eventEndDate;

  final DateTime createdAt;

  final DateTime updatedAt;

  final NewsUser moderator;

  final NewsUser organizer;

  News(
      {required this.id,
      required this.title,
      required this.content,
      required this.imageThumbnail,
      required this.state,
      required this.publicationDate,
      required this.eventStartDate,
      required this.eventEndDate,
      required this.createdAt,
      required this.updatedAt,
      required this.moderator,
      required this.organizer});

  /// Used to create [CourseActivity] instance from a JSON file
  factory News.fromJson(Map<String, dynamic> map) => News(
      id: map['id'] as String,
      title: map['title'] as String,
      content: map['content'] as String,
      imageThumbnail: map['imageThumbnail'] as String,
      state: map['state'] as int,
      publicationDate: DateTime.parse(map['publicationDate'] as String),
      eventStartDate: DateTime.parse(map['eventStartDate'] as String),
      eventEndDate: DateTime.parse(map['eventEndDate'] as String),
      createdAt: DateTime.parse(map['createdAt'] as String),
      updatedAt: DateTime.parse(map['updatedAt'] as String),
      moderator: NewsUser.fromJson(map['moderator']),
      organizer: NewsUser.fromJson(map['organizer']));

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'content': content,
        'imageThumbnail': imageThumbnail,
        'state': state,
        'publicationDate': publicationDate.toString(),
        'eventStartDate': eventStartDate.toString(),
        'eventEndDate': eventEndDate.toString(),
        'createdAt': createdAt.toString(),
        'updatedAt': updatedAt.toString(),
        'moderator': moderator.toJson(),
        'organizer': organizer.toJson(),
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is News &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          content == other.content &&
          imageThumbnail == other.imageThumbnail &&
          state == other.state &&
          publicationDate == other.publicationDate &&
          eventStartDate == other.eventStartDate &&
          eventEndDate == other.eventEndDate &&
          createdAt == other.createdAt &&
          updatedAt == other.updatedAt &&
          moderator == other.moderator &&
          organizer == other.organizer;

  @override
  int get hashCode =>
      id.hashCode ^
      title.hashCode ^
      content.hashCode ^
      imageThumbnail.hashCode ^
      state.hashCode ^
      publicationDate.hashCode ^
      eventStartDate.hashCode ^
      eventEndDate.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode ^
      moderator.hashCode ^
      organizer.hashCode;
}
