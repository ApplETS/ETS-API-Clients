/// Data-class that represents an organizer
class Organizer {
  /// Organizer unique Id
  final String id;

  /// Organizer name
  final String? name;

  /// Organizer email
  final String? email;

  /// Organizer avatar URL
  final String? avatarUrl;

  /// Organizer type
  final String? type;

  /// Organizer's organization
  final String? organization;

  /// Organizer's activity area
  final String? activityArea;

  /// Whether the organizer is active
  final bool? isActive;

  /// Organizer's profile description
  final String? profileDescription;

  /// Organizer's Facebook link
  final String? facebookLink;

  /// Organizer's Instagram link
  final String? instagramLink;

  /// Organizer's TikTok link
  final String? tikTokLink;

  /// Organizer's X link
  final String? xLink;

  /// Organizer's Discord link
  final String? discordLink;

  /// Organizer's LinkedIn link
  final String? linkedInLink;

  /// Organizer's Reddit link
  final String? redditLink;

  /// Organizer's website link
  final String? webSiteLink;

  /// The date that the organizer was created at
  final DateTime createdAt;

  /// The date that the organizer was last updated at
  final DateTime updatedAt;

  Organizer({
    required this.id,
    this.name,
    this.email,
    this.avatarUrl,
    this.type,
    this.organization,
    this.activityArea,
    this.isActive,
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
    required this.updatedAt,
  });

  /// Used to create [Organizer] instance from a JSON file
  factory Organizer.fromJson(Map<String, dynamic> map) => Organizer(
        id: map['id'] as String,
        name: map['name'] as String?,
        email: map['email'] as String?,
        avatarUrl: map['avatarUrl'] as String?,
        type: map['type'] as String?,
        organization: map['organization'] as String?,
        activityArea: map['activityArea'] as String?,
        isActive: map['isActive'] as bool?,
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
        updatedAt: DateTime.parse(map['updatedAt'] as String),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'avatarUrl': avatarUrl,
        'type': type,
        'organization': organization,
        'activityArea': activityArea,
        'isActive': isActive,
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
}
