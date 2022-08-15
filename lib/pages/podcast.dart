import 'dart:developer';
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
        data: (Podcast p) {
          inspect(p);
          return PodcastWidget(p);
        },
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
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
          snap: false,
          floating: false,
          expandedHeight: 200.0,
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.add_circle),
              tooltip: 'Add new entry',
              onPressed: () {/* ... */},
            ),
          ],
          flexibleSpace: FlexibleSpaceBar(
            title: Text(
              podcast.title ?? 'Podcast',
            ),
            background: Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.amber,
                  ),
                ),
              ],
            ),
            collapseMode: CollapseMode.pin,
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              Episode ep = podcast.episodes![index];
              return Card(
                child: ListTile(
                  leading: const Icon(Icons.podcasts_rounded),
                  title: Text(ep.title),
                  trailing: IconButton(
                    onPressed: () {
                      ref.read(playbackProvider.notifier).loadAudio(
                            url: podcast.episodes?[index].contentUrl ?? "",
                            episode: podcast.episodes?[index].title ?? "",
                            podcast: podcast.episodes?[index].author ?? "",
                            imageUrl: podcast.episodes?[index].imageUrl ??
                                podcast.image,
                          );
                    },
                    icon: const Icon(Icons.play_arrow_rounded),
                  ),
                ),
              );
            },
            childCount: podcast.episodes?.length,
          ),
        ),
      ],
    );
  }
}
