/// Data-class that represent an entry page of a what's new
class WhatsNewPage {
  /// WhatsNew Id stored in API
  final String title;

  /// The project id that this whats new belongs to
  final String description;

  /// The mediaURL of the image or gif associated with this what's new
  final String? mediaUrl;

  /// Color as an hexadecimal string
  final String color;

  WhatsNewPage(
      {required this.title,
      required this.description,
      this.mediaUrl,
      required this.color});

  /// Used to create [WhatsNewPage] instance from a JSON file
  factory WhatsNewPage.fromJson(Map<String, dynamic> map) => WhatsNewPage(
      title: map['title'] as String,
      description: map['description'] as String,
      mediaUrl: map['mediaUrl'] as String?,
      color: map['color'] as String);

  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
        'mediaUrl': mediaUrl,
        'color': color,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WhatsNewPage &&
          runtimeType == other.runtimeType &&
          title == other.title &&
          description == other.description &&
          mediaUrl == other.mediaUrl &&
          color == other.color;

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      title.hashCode ^
      description.hashCode ^
      mediaUrl.hashCode ^
      color.hashCode;
}
