import 'dart:developer';

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
                            crossAxisCount: 3),
                    itemCount: charts.items.length,
                    padding: const EdgeInsets.only(
                      bottom: 90,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          context.goNamed('podcast', queryParams: {
                            'podcastUrl': charts.items[index].feedUrl!
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.all(8),
                          clipBehavior: Clip.hardEdge,
                          decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 15, 15, 15),
                              borderRadius: BorderRadius.all(
                                Radius.circular(18),
                              )),
                          child: Column(
                            children: [
                              Image.network(
                                  charts.items[index].artworkUrl100 ?? ""),
                              Text(charts.items[index].artistName ?? "Podcast"),
                            ],
                          ),
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
