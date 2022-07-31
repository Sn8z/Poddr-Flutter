import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:podcast_search/podcast_search.dart';

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
  final Search podcastSearch = Search();

  Future<SearchResult> search(String query) {
    return podcastSearch.search(
      query,
      country: Country.SWEDEN,
    );
  }

  Future<SearchResult> charts() {
    return podcastSearch.charts();
  }

  Future<Podcast> loadFeed(String url) {
    return Podcast.loadFeed(
      url: url,
      userAgent: 'Poddr',
    );
  }
}
