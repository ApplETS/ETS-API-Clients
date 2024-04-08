import 'package:ets_api_clients/src/models/activity_area.dart';

class NewsUser {
  /// News user unique Id
  final String id;

  /// The news user email
  final String email;

  /// The user type
  final String type;

  final String? organization;

  final ActivityArea? activityArea;

  final String? profileDescription;

  final String? facebookLink;

  final String? instagramLink;

  final String? tikTokLink;

  final String? xLink;

  final String? discordLink;

  final String? linkedInLink;

  final String? redditLink;

  final String? webSiteLink;

  final DateTime createdAt;

  final DateTime updatedAt;

  NewsUser(
      {required this.id,
      required this.email,
      required this.type,
      this.organization,
      this.activityArea,
      this.profileDescription,
      this.facebookLink,
      this.instagramLink,
      this.tikTokLink,
      this.xLink,
      this.discordLink,
      this.linkedInLink,
      this.redditLink,
      this.webSiteLink,
      required this.createdAt,
      required this.updatedAt});

  /// Used to create [CourseActivity] instance from a JSON file
  factory NewsUser.fromJson(Map<String, dynamic> map) => NewsUser(
      id: map['id'] as String,
      email: map['email'] as String,
      type: map['type'] as String,
      organization: map['organization'] as String?,
      activityArea: ActivityArea.fromJson(map['activityArea']),
      profileDescription: map['profileDescription'] as String?,
      facebookLink: map['facebookLink'] as String?,
      instagramLink: map['instagramLink'] as String?,
      tikTokLink: map['tikTokLink'] as String?,
      xLink: map['xLink'] as String?,
      discordLink: map['discordLink'] as String?,
      linkedInLink: map['linkedInLink'] as String?,
      redditLink: map['redditLink'] as String?,
      webSiteLink: map['webSiteLink'] as String?,
      createdAt: DateTime.parse(map['createdAt'] as String),
      updatedAt: DateTime.parse(map['updatedAt'] as String));

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'type': type,
        'organization': organization,
        'activityArea': activityArea?.toJson(),
        'profileDescription': profileDescription,
        'facebookLink': facebookLink,
        'instagramLink': instagramLink,
        'tikTokLink': tikTokLink,
        'xLink': xLink,
        'discordLink': discordLink,
        'linkedInLink': linkedInLink,
        'redditLink': redditLink,
        'webSiteLink': webSiteLink,
        'createdAt': createdAt.toString(),
        'updatedAt': updatedAt.toString(),
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NewsUser &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          email == other.email &&
          type == other.type &&
          organization == other.organization &&
          activityArea == other.activityArea &&
          profileDescription == other.profileDescription &&
          facebookLink == other.facebookLink &&
          instagramLink == other.instagramLink &&
          tikTokLink == other.tikTokLink &&
          xLink == other.xLink &&
          discordLink == other.discordLink &&
          linkedInLink == other.linkedInLink &&
          redditLink == other.redditLink &&
          webSiteLink == other.webSiteLink &&
          createdAt == other.createdAt &&
          updatedAt == other.updatedAt;

  @override
  int get hashCode =>
      id.hashCode ^
      email.hashCode ^
      type.hashCode ^
      organization.hashCode ^
      activityArea.hashCode ^
      profileDescription.hashCode ^
      facebookLink.hashCode ^
      instagramLink.hashCode ^
      tikTokLink.hashCode ^
      xLink.hashCode ^
      discordLink.hashCode ^
      linkedInLink.hashCode ^
      redditLink.hashCode ^
      webSiteLink.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode;
}
