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
  late MonETSAPIClient service;
  late MockClient mockClient;

  group('MonETSApi - ', () {
    setUp(() {
      // default response stub
      mockClient = MockClient((request) => Future.value(Response("", 200)));

      service = MonETSAPIClient(client: mockClient);
    });

    tearDown(() {
      mockClient.close();
    });
    group('authentication - ', () {
      test('right credentials', () async {
        const String username = "username";
        const String password = "password";

        mockClient = HttpClientMockHelper.stubJsonPost(
            Urls.authenticationMonETS,
            {'Domaine': 'domaine', 'TypeUsagerId': 1, 'Username': username});
        service = buildService(mockClient);

        mockClient = MockClient((request) async {
          return Response(
              jsonEncode({
                "Domaine": "domaine",
                "TypeUsagerId": 1,
                "Username": username
              }),
              200);
        });

        final result =
            await service.authenticate(username: username, password: password);

        expect(result, isA<MonETSUser>());
        expect(result.username, username);
      });

      test('wrong credentials / any other errors for now', () async {
        const int statusCode = 500;
        const String message = "An error has occurred.";

        mockClient = HttpClientMockHelper.stubJsonPost(
            Urls.authenticationMonETS, {"Message": message}, statusCode);
        service = buildService(mockClient);

        expect(service.authenticate(username: "", password: ""),
            throwsA(isA<HttpException>()));
      });
    });
  });
}

MonETSAPIClient buildService(MockClient client) =>
    MonETSAPIClient(client: client);
