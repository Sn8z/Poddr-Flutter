import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:podcast_search/podcast_search.dart';
import 'package:poddr/components/base.dart';
import 'package:poddr/components/card.dart';
import 'package:poddr/helpers/breakpoints.dart';
import 'package:poddr/services/api_service.dart';
import 'package:go_router/go_router.dart';

class ToplistPage extends ConsumerWidget {
  const ToplistPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<SearchResult> charts = ref.watch(chartsProvider);
    return BaseWidget(
      child: LayoutBuilder(builder: (context, constraints) {
        int gridWidth = 2;
        if (constraints.maxWidth > Breakpoints.desktopScreen) {
          gridWidth = 5;
        } else if (constraints.maxWidth > Breakpoints.tabletScreen) {
          gridWidth = 3;
        } else {
          gridWidth = 2;
        }
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Charts',
                  style: TextStyle(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black,
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            charts.when(data: (SearchResult charts) {
              inspect(charts);
              return Expanded(
                child: RefreshIndicator(
                  onRefresh: (() async {
                    ref.refresh(chartsProvider);
                  }),
                  child: GridView.builder(
                    controller: ScrollController(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: gridWidth,
                      childAspectRatio: 0.8,
                    ),
                    itemCount: charts.items.length,
                    padding: const EdgeInsets.only(
                      bottom: 90,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      Item podcast = charts.items[index];

                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: CardComponent(
                            title: podcast.trackName ?? '',
                            subtitle: podcast.artistName ?? '',
                            imgUrl: podcast.artworkUrl600,
                            onTap: () {
                              context.pushNamed('podcast', queryParams: {
                                'podcastUrl': podcast.feedUrl!
                              });
                            }),
                      );
                    },
                  ),
                ),
              );
            }, error: (e, st) {
              return const Text("Error");
            }, loading: () {
              return const LinearProgressIndicator();
            }),
          ],
        );
      }),
    );
  }
}
