import 'package:ets_api_clients/src/constants/urls.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';

import 'package:ets_api_clients/models.dart';
import 'package:ets_api_clients/src/constants/http_exception.dart';
import 'package:ets_api_clients/clients.dart';
import 'package:test/test.dart';

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
          'pageNumber': 1.toString(),
          'pageSize': 10.toString(),
        };
        final uri = Uri.https(Urls.helloNewsAPI, '/api/events', query);
        mockClient = HttpClientMockHelper.stubJsonGet(uri.toString(), {
          'data': [],
          'pageNumber': 1,
          'pageSize': 10,
          'totalPages': 1,
          'totalRecords': 0
        });
        service = buildService(mockClient);

        final result = await service.getEvents();

        expect(result, isA<PaginatedNews>());
        expect(result.news.length, 0);
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
            tags: [],
            moderator: NewsUser(
              id: "3783f79f-da78-4486-8a5a-7b855b856033",
              email: "email",
              type: "moderator",
              createdAt: DateTime.now().subtract(const Duration(days: 30)),
              updatedAt: DateTime.now().subtract(const Duration(days: 30)),
            ),
            organizer: NewsUser(
              id: "3a5cb049-67cf-428e-b98f-ef29fb633e0d",
              organisation: "name2",
              email: "email2",
              type: "organizer",
              createdAt: DateTime.now().subtract(const Duration(days: 30)),
              updatedAt: DateTime.now().subtract(const Duration(days: 30)),
            ));

        final query = {
          'pageNumber': 1.toString(),
          'pageSize': 10.toString(),
        };
        final uri = Uri.https(Urls.helloNewsAPI, '/api/events', query);
        mockClient = HttpClientMockHelper.stubJsonGet(uri.toString(), {
          'data': [news],
          'pageNumber': 1,
          'pageSize': 10,
          'totalPages': 1,
          'totalRecords': 1
        });
        service = buildService(mockClient);

        final result = await service.getEvents();

        expect(result, isA<PaginatedNews>());
        expect(result.news.length, 1);
        expect(result.news[0].id, "402e711c-0f72-4aab-9684-31f1956c1da1");
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
