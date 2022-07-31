import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:podcast_search/podcast_search.dart';
import 'package:poddr/components/base.dart';
import 'package:poddr/components/header.dart';
import 'package:poddr/services/api_service.dart';
import 'package:poddr/services/audio_service.dart';

class PodcastPage extends ConsumerWidget {
  const PodcastPage({Key? key, this.url = ""}) : super(key: key);

  final String url;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<Podcast> podcast = ref.watch(podcastProvider(url));
    return BaseWidget(
      child: podcast.when(
        data: (Podcast p) => PodcastWidget(p),
        error: (e, __) {
          return Column(
            children: [
              const Header(title: 'Something went wrong'),
              Text(e.toString()),
            ],
          );
        },
        loading: () {
          return Column(
            children: const [
              Header(title: ''),
              LinearProgressIndicator(),
            ],
          );
        },
      ),
    );
  }
}

class PodcastWidget extends ConsumerWidget {
  const PodcastWidget(this.podcast, {Key? key}) : super(key: key);
  final Podcast podcast;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Header(title: podcast.title ?? ""),
        Expanded(
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            controller: ScrollController(),
            itemCount: podcast.episodes?.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(podcast.episodes?[index].title ?? "Missing title"),
                trailing: IconButton(
                  icon: const Icon(Icons.play_arrow),
                  onPressed: () {
                    ref.read(playbackProvider.notifier).loadAudio(
                          url: podcast.episodes?[index].contentUrl ?? "",
                          episode: podcast.episodes?[index].title ?? "",
                          podcast: podcast.episodes?[index].author ?? "",
                          imageUrl: podcast.episodes?[index].imageUrl,
                        );
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
