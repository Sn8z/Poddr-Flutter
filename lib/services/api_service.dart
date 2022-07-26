import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:podcast_search/podcast_search.dart';

final podcastSearchProvider =
    FutureProvider.autoDispose.family<Future, String>((Ref ref, String query) {
  return ref.read(apiProvider).search(query);
});

final chartsProvider = FutureProvider((ref) {
  return ref.read(apiProvider).charts();
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

  Future<SearchResult> charts() async {
    try {
      SearchResult result = await podcastSearch.charts();
      return result;
    } on Exception catch (e) {
      print(e.toString());
      throw Exception(e);
    }
  }
}

final apiProvider = Provider<ApiService>((ref) {
  return ApiService();
});
