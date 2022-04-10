import 'models/whats_new.dart';

/// A Wrapper for all calls to Portal ApplETS API.
abstract class IPortalAPIClient {
  /// Call the Portal API to get the list of all the [WhatsNew] for the app user
  /// that requested it
  Future<WhatsNew> getWhatsNewForVersion({required String version});
}
