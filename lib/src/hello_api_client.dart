import 'models/paginated_news.dart';

/// A Wrapper for all calls to Hello API.
abstract class IHelloAPIClient {
  /// Call the Hello API to get the news
  /// [startDate] The start date of the news (optional)
  /// [endDate] The end date of the news (optional)
  /// [tags] The tags of the news (optional)
  /// [activityAreas] The activity areas of the news (optional)
  /// [pageNumber] The page number (default: 1)
  /// [pageSize] The page size (default: 10)
  Future<PaginatedNews> getEvents(
      {DateTime? startDate,
      DateTime? endDate,
      List<String>? tags,
      List<String>? activityAreas,
      int pageNumber = 1,
      int pageSize = 10});
}
