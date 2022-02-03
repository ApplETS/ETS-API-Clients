import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';

import 'package:ets_api_clients/models.dart';
import 'package:ets_api_clients/src/constants/http_exception.dart';
import 'package:ets_api_clients/clients.dart';

void main() {
  MonETSAPIClient service;
  MockClient mockClient;
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

        mockClient.close();
      });

      test('wrong credentials / any other errors for now', () async {
        const int statusCode = 500;
        const String message = "An error has occurred.";

        MockClient mockClient = MockClient((request) async {
          return Response(jsonEncode({"Message": message}), statusCode);
        });

        expect(service.authenticate(username: "", password: ""),
            throwsA(isInstanceOf<HttpException>()));

        mockClient.close();
      });
    });
  });
}
