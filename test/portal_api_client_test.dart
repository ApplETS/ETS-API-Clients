import 'dart:convert';

import 'package:ets_api_clients/src/constants/urls.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';

import 'package:ets_api_clients/models.dart';
import 'package:ets_api_clients/src/constants/http_exception.dart';
import 'package:ets_api_clients/clients.dart';
import 'package:test/test.dart';

import 'mocks/http_client_mock_helper.dart';

void main() {
  late PortalAPIClient service;
  late MockClient mockClient;

  group('PortalAPI - ', () {
    setUp(() {
      // default response stub
      mockClient = MockClient((request) => Future.value(Response("", 200)));
    });

    tearDown(() {
      mockClient.close();
    });
    group('getWhatsNewForVersion - ', () {
      test('right information', () async {
        const String _projectId = "12345";
        const String version = "4.9.4";

        mockClient = HttpClientMockHelper.stubGet(
            Urls.portalAPI +
                '/api/projects/' +
                _projectId +
                '/whatsnew/' +
                version,
            jsonEncode({
              "id": "12345",
              "projectId": _projectId,
              "version": version,
              "pages": [
                {
                  "title": "Page test 1",
                  "description": "Pages are meant to define What's new entry",
                  "mediaUrl": "https://example.com/giphy.gif",
                  "color": "AD1316"
                }
              ]
            }).toString());
        service = buildService(_projectId, mockClient);

        final whatsNew = await service.getWhatsNewForVersion(version: version);

        expect(whatsNew, isA<WhatsNew>());
        expect(whatsNew.version, version);
        expect(whatsNew.id, "12345");
        expect(whatsNew.projectId, _projectId);
        expect(whatsNew.pages.length, 1);
        expect(whatsNew.pages[0], isA<WhatsNewPage>());
        expect(whatsNew.pages[0].title, "Page test 1");
        expect(whatsNew.pages[0].description,
            "Pages are meant to define What's new entry");
        expect(whatsNew.pages[0].mediaUrl, "https://example.com/giphy.gif");
        expect(whatsNew.pages[0].color, "AD1316");
      });

      test('wrong project id / any other errors for now', () async {
        const String _projectId = "12345";
        const String version = "0.0.1";
        const int statusCode = 400;
        const String message =
            "Fetching a WhatsNew has failed with the following: Sequence contains no elements";

        mockClient = HttpClientMockHelper.stubGet(
            Urls.portalAPI +
                '/api/projects/' +
                _projectId +
                '/whatsnew/' +
                version,
            message,
            statusCode);
        service = buildService(_projectId, mockClient);

        expect(service.getWhatsNewForVersion(version: version),
            throwsA(isA<HttpException>()));
      });
    });
  });
}

PortalAPIClient buildService(String projectId, MockClient client) =>
    PortalAPIClient(projectId, url: Urls.portalAPI, client: client);
