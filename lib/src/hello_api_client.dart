import 'package:ets_api_clients/src/models/organizer.dart';
import 'package:ets_api_clients/src/models/report.dart';

import 'models/paginated_news.dart';

/// A Wrapper for all calls to Hello API.
abstract class IHelloAPIClient {
  /// Call the Hello API to get the news
  /// [startDate] The start date of the news (optional)
  /// [endDate] The end date of the news (optional)
  /// [tags] The tags of the news (optional)
  /// [activityAreas] The activity areas of the news (optional)
  /// [organizerId] The organizer id (optional)
  /// [title] The news title (optional)
  /// [pageNumber] The page number (default: 1)
  /// [pageSize] The page size (default: 10)
  Future<PaginatedNews> getEvents(
      {DateTime? startDate,
      DateTime? endDate,
      List<String>? tags,
      List<String>? activityAreas,
      String? organizerId,
      String? title,
      int pageNumber = 1,
      int pageSize = 10});

  /// Call the Hello API to get the organizer
  /// [organizerId] The organizer id
  Future<Organizer?> getOrganizer(String organizerId);

  /// Call the Hello API to report a news
  /// [newsId] The news id
  /// [report] The report
  Future<bool> reportNews(String newsId, Report report);
}
