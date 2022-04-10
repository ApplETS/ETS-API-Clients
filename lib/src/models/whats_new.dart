import 'package:ets_api_clients/src/models/whats_new_page.dart';

/// Data-class that represent a What's new entry
class WhatsNew {
  /// WhatsNew Id stored in API
  final String id;

  /// The project id that this whats new belongs to
  final String projectId;

  /// The version of the what's new
  final String version;

  /// Description of the activity
  /// (ex: "Laboratoire (Groupe A)")
  final List<WhatsNewPage> pages;

  WhatsNew(
      {required this.id,
      required this.projectId,
      required this.version,
      required this.pages});

  /// Used to create [WhatsNew] instance from a JSON file
  factory WhatsNew.fromJson(Map<String, dynamic> map) => WhatsNew(
      id: map['id'] as String,
      projectId: map['projectId'] as String,
      version: map['version'] as String,
      pages: (map['pages'] as List<dynamic>)
          .map((e) => WhatsNewPage.fromJson(e as Map<String, dynamic>))
          .toList());

  Map<String, dynamic> toJson() => {
        'id': id,
        'projectId': projectId,
        'version': version,
        'pages': pages.map((e) => e.toJson()),
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WhatsNew &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          projectId == other.projectId &&
          version == other.version &&
          pages == other.pages;

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      id.hashCode ^
      projectId.hashCode ^
      version.hashCode ^
      pages.hashCode;
}
