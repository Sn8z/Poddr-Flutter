import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:podcast_search/podcast_search.dart';
import 'package:poddr/components/base.dart';
import 'package:poddr/components/header.dart';
import 'package:poddr/services/api_service.dart';
import 'package:go_router/go_router.dart';

class ToplistPage extends ConsumerWidget {
  const ToplistPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<SearchResult> charts = ref.watch(chartsProvider);
    return BaseWidget(
      child: LayoutBuilder(builder: (context, constraints) {
        return Column(
          children: [
            const Header(
              title: 'Charts',
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
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                    itemCount: charts.items.length,
                    padding: const EdgeInsets.only(
                      bottom: 90,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          context.pushNamed('podcast', queryParams: {
                            'podcastUrl': charts.items[index].feedUrl!
                          });
                        },
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            CachedNetworkImage(
                              imageUrl: charts.items[index].artworkUrl600 ??
                                  charts.items[index].artworkUrl ??
                                  "",
                              fit: BoxFit.contain,
                              errorWidget: (context, url, error) {
                                return Image.asset(
                                    'assets/images/placeholder.png');
                              },
                              placeholder: (context, url) {
                                return const CircularProgressIndicator();
                              },
                            ),
                            Positioned(
                              child: Text(
                                charts.items[index].artistName ?? "",
                                overflow: TextOverflow.ellipsis,
                              ),
                              bottom: 0,
                              left: 0,
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
              );
            }, error: (e, st) {
              return Text("Error");
            }, loading: () {
              return const LinearProgressIndicator();
            }),
          ],
        );
      }),
    );
  }
}
