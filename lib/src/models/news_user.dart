class NewsUser {
  /// News user unique Id
  final String id;

  /// The user name
  final String name;

  /// The news user email
  final String email;

  /// The user type
  final String type;

  final String? organisation;

  final String? activityArea;

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
      required this.name,
      required this.email,
      required this.type,
      this.organisation,
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
      name: map['name'] as String,
      email: map['email'] as String,
      type: map['type'] as String,
      organisation: map['organisation'] as String?,
      activityArea: map['activityArea'] as String?,
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
        'name': name,
        'email': email,
        'type': type,
        'organisation': organisation,
        'activityArea': activityArea,
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
          name == other.name &&
          email == other.email &&
          type == other.type &&
          organisation == other.organisation &&
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
      name.hashCode ^
      email.hashCode ^
      type.hashCode ^
      organisation.hashCode ^
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
