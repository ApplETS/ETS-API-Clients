import 'package:ets_api_clients/clients.dart';

void main() async {
  final portal = PortalAPIClient('12345abcdef', url: 'https://example.com');
  final signets = SignetsAPIClient();
  final monETS = MonETSAPIClient();

  final whatsnew = await portal.getWhatsNewForVersion(version: 'x.x.x');
  final course =
      await signets.getCourses(username: 'username', password: 'password');
  final user =
      await monETS.authenticate(username: 'username', password: 'password');
}
