import 'package:ets_api_clients/src/constants/urls.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';

import 'package:ets_api_clients/models.dart';
import 'package:ets_api_clients/src/constants/http_exception.dart';
import 'package:ets_api_clients/clients.dart';

import 'mocks/http_client_mock_helper.dart';

void main() {
  late HelloAPIClient service;
  late MockClient mockClient;

  group('HelloApi - ', () {
    setUp(() {
      // default response stub
      mockClient = MockClient((request) => Future.value(Response("", 200)));

      service = HelloAPIClient(client: mockClient);
    });

    tearDown(() {
      mockClient.close();
    });

    group('getEvents - ', () {
      test('empty data', () async {
        final query = {
          'startDate': null,
          'endDate': null,
          'tags': null,
          'activityAreas': null,
          'pageNumber': 1.toString(),
          'pageSize': 10.toString(),
        };
        final uri = Uri.http(Urls.helloNewsAPI, '/api/news', query);
        mockClient = HttpClientMockHelper.stubJsonGet(uri.toString(), {
          'data': [],
          'pageNumber': 1,
          'pageSize': 10,
          'totalPages': 1,
          'totalRecords': 0
        });
        service = buildService(mockClient);

        final result = await service.getEvents();

        expect(result, isA<List<News>>());
        expect(result.length, 0);
      });

      test('one news', () async {
        final news = News(
            id: "402e711c-0f72-4aab-9684-31f1956c1da1",
            title: "title",
            content: "content",
            imageUrl: "imageUrl",
            state: 1,
            publicationDate: DateTime.now(),
            eventStartDate: DateTime.now().add(const Duration(days: 4)),
            eventEndDate: DateTime.now().add(const Duration(days: 4, hours: 2)),
            createdAt: DateTime.now().subtract(const Duration(days: 4)),
            updatedAt: DateTime.now().subtract(const Duration(days: 4)),
            moderator: NewsUser(
              id: "3783f79f-da78-4486-8a5a-7b855b856033",
              name: "name",
              email: "email",
              type: "moderator",
              createdAt: DateTime.now().subtract(const Duration(days: 30)),
              updatedAt: DateTime.now().subtract(const Duration(days: 30)),
            ),
            organizer: NewsUser(
              id: "3a5cb049-67cf-428e-b98f-ef29fb633e0d",
              name: "name2",
              email: "email2",
              type: "organizer",
              createdAt: DateTime.now().subtract(const Duration(days: 30)),
              updatedAt: DateTime.now().subtract(const Duration(days: 30)),
            ));

        final query = {
          'startDate': null,
          'endDate': null,
          'tags': null,
          'activityAreas': null,
          'pageNumber': 1.toString(),
          'pageSize': 10.toString(),
        };
        final uri = Uri.http(Urls.helloNewsAPI, '/api/news', query);
        mockClient = HttpClientMockHelper.stubJsonGet(uri.toString(), {
          'data': [news],
          'pageNumber': 1,
          'pageSize': 10,
          'totalPages': 1,
          'totalRecords': 1
        });
        service = buildService(mockClient);

        final result = await service.getEvents();

        expect(result, isA<List<News>>());
        expect(result.length, 1);
        expect(result[0].id, "402e711c-0f72-4aab-9684-31f1956c1da1");
      });

      test('any other errors for now', () async {
        const int statusCode = 500;
        const String message = "An error has occurred.";

        mockClient = HttpClientMockHelper.stubJsonPost(
            Urls.helloNewsAPI, {"Message": message}, statusCode);
        service = buildService(mockClient);

        expect(service.getEvents(), throwsA(isA<HttpException>()));
      });
    });
  });
}

HelloAPIClient buildService(MockClient client) =>
    HelloAPIClient(client: client);
