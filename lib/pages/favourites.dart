import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:poddr/components/base.dart';
import 'package:poddr/components/card.dart';
import 'package:poddr/components/list_item.dart';
import 'package:poddr/components/sliver_app_bar.dart';
import 'package:poddr/helpers/breakpoints.dart';
import 'package:poddr/services/db_service.dart';

class FavouritesPage extends ConsumerWidget {
  const FavouritesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<dynamic>> favStream = ref.watch(favStreamProvider);
    return BaseWidget(
      child: LayoutBuilder(builder: (context, constraints) {
        if (constraints.maxWidth > Breakpoints.tabletScreen) {
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Favourites',
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
              Expanded(
                child: GridView.count(
                  controller: ScrollController(),
                  childAspectRatio: 0.8,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  crossAxisCount:
                      constraints.maxWidth > Breakpoints.desktopScreen ? 5 : 4,
                  children: List.generate(100, (index) {
                    return CardComponent(
                      title: 'Title',
                      subtitle: 'Music',
                      onTap: () {},
                    );
                  }),
                ),
              ),
            ],
          );
        } else {
          return CustomScrollView(
            controller: ScrollController(),
            slivers: [
              const CustomSliverBar(
                  title: 'Favourites', description: 'Your favourites'),
              favStream.when(data: (data) {
                if (data.isEmpty) {
                  return const Text('No favourites added');
                } else {
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final fav = data[index];
                        return ListItemComponent(
                          title: fav['title'],
                          imgUrl: fav['image'],
                          onTap: () {
                            context.push('/podcast?podcastUrl=${fav['rss']}');
                          },
                          actions: [
                            PopupMenuButton(
                              itemBuilder: (context) {
                                return [
                                  PopupMenuItem(
                                    child: IconButton(
                                      onPressed: () {
                                        ref
                                            .read(favouritesProvider)
                                            .removeFavourite(
                                                data[index]?['rss']);
                                      },
                                      icon: const Icon(Icons.cancel_rounded),
                                    ),
                                  ),
                                ];
                              },
                            ),
                          ],
                        );
                      },
                      childCount: data.length,
                    ),
                  );
                }
              }, error: (e, st) {
                debugPrint(e.toString());
                inspect(e);
                inspect(st);
                return SliverList(
                  delegate: SliverChildListDelegate([
                    Text(e.toString()),
                  ]),
                );
              }, loading: () {
                return SliverList(
                  delegate: SliverChildListDelegate([
                    const LinearProgressIndicator(),
                  ]),
                );
              }),
            ],
          );
        }
      }),
    );
  }
}
