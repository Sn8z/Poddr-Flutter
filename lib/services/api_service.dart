import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:podcast_search/podcast_search.dart';
import 'package:poddr/helpers/user_agent.dart';

final podcastSearchProvider =
    FutureProvider.autoDispose.family<Future, String>((Ref ref, String query) {
  return ref.read(apiProvider).search(query);
});

final chartsProvider = FutureProvider.autoDispose((ref) {
  return ref.read(apiProvider).charts();
});

final podcastProvider =
    FutureProvider.autoDispose.family<Podcast, String>((Ref ref, String url) {
  return ref.read(apiProvider).loadFeed(url);
});

final apiProvider = Provider<ApiService>((ref) {
  return ApiService();
});

class ApiService {
  final Search podcastSearch = Search(userAgent: getUserAgent());

  Future<SearchResult> search(String query) {
    return podcastSearch.search(
      query,
      explicit: true,
      limit: 30,
    );
  }

  Future<SearchResult> charts() {
    return podcastSearch.charts(
      explicit: true,
      limit: 30,
    );
  }

  Future<Podcast> loadFeed(String url) {
    return Podcast.loadFeed(
      url: url,
      userAgent: getUserAgent(),
      timeout: 30000,
    );
  }
}
