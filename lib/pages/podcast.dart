import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:podcast_search/podcast_search.dart';
import 'package:poddr/components/base.dart';
import 'package:poddr/components/header.dart';
import 'package:poddr/components/list_item.dart';
import 'package:poddr/components/sliver_app_bar.dart';
import 'package:poddr/services/api_service.dart';
import 'package:poddr/services/audio_service.dart';
import 'package:poddr/services/db_service.dart';
import 'package:poddr/services/dialog_service.dart';

class PodcastPage extends ConsumerWidget {
  const PodcastPage({Key? key, this.url = ""}) : super(key: key);

  final String url;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<Podcast> podcast = ref.watch(podcastProvider(url));
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
      controller: ScrollController(),
      slivers: [
        CustomSliverBar(
          title: podcast.title ?? '',
          description: podcast.description ?? '',
          image: podcast.image,
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.arrow_back_rounded),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.play_arrow_rounded),
            ),
            IconButton(
              onPressed: () {
                ref.read(favouritesProvider).addFavourite(
                      rss: podcast.url!,
                      title: podcast.title!,
                      image: podcast.image!,
                    );
              },
              icon: const Icon(Icons.favorite_outline_rounded),
            ),
          ],
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              Episode ep = podcast.episodes![index];
              return Column(
                children: [
                  ListItemComponent(
                    title: ep.title,
                    subtitle: ep.description,
                    imgUrl: ep.imageUrl,
                    onTap: () {
                      ref.read(playbackProvider.notifier).loadAudio(
                            url: podcast.episodes?[index].contentUrl ?? "",
                            episode: podcast.episodes?[index].title ?? "",
                            podcast: podcast.episodes?[index].author ?? "",
                            imageUrl: podcast.episodes?[index].imageUrl ??
                                podcast.image,
                          );
                    },
                    actions: [
                      IconButton(
                          iconSize: 26,
                          onPressed: () {},
                          icon: const Icon(Icons.more_vert_rounded)),
                    ],
                    subActions: [
                      IconButton(
                        iconSize: 18,
                        onPressed: () {
                          DialogService().dialog(context);
                        },
                        icon: const Icon(Icons.info_outline_rounded),
                      ),
                      IconButton(
                        iconSize: 18,
                        onPressed: () {},
                        icon: const Icon(Icons.circle_outlined),
                      ),
                    ],
                  ),
                  const Divider(),
                ],
              );
            },
            childCount: podcast.episodes?.length,
          ),
        ),
      ],
    );
  }
}
