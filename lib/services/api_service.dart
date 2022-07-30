import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:podcast_search/podcast_search.dart';

final podcastSearchProvider =
    FutureProvider.autoDispose.family<Future, String>((Ref ref, String query) {
  return ref.read(apiProvider).search(query);
});

final chartsProvider = FutureProvider((ref) {
  return ref.read(apiProvider).charts();
});

final podcastProvider =
    FutureProvider.autoDispose.family<Podcast, String>((Ref ref, String url) {
  return Podcast.loadFeed(
    url: url,
    userAgent: 'Poddr',
  );
});

class ApiService {
  final Search podcastSearch = Search();

  Future search(String query) async {
    SearchResult results = await podcastSearch.search(
      query,
      country: Country.SWEDEN,
    );
    return results;
  }

  Future<SearchResult> charts() {
    return podcastSearch.charts();
  }
}

final apiProvider = Provider<ApiService>((ref) {
  return ApiService();
});
