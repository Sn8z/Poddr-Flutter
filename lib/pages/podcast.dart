import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:podcast_search/podcast_search.dart';
import 'package:poddr/components/header.dart';
import 'package:poddr/services/api_service.dart';

class PodcastPage extends ConsumerWidget {
  const PodcastPage({Key? key, this.url = ""}) : super(key: key);

  final String url;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<Podcast> podcast = ref.watch(podcastProvider(url));
    return Column(
      children: [
        Header(title: "Title"),
        Text("Text"),
        ElevatedButton(
          onPressed: () {},
          child: podcast.when(
            data: (p) => Text(p.episodes?[0].title ?? "Title"),
            error: (e, __) => Text(e.toString()),
            loading: () => const CircularProgressIndicator(),
          ),
        ),
      ],
    );
  }
}
