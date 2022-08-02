import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:podcast_search/podcast_search.dart';
import 'package:poddr/components/base.dart';
import 'package:poddr/components/header.dart';
import 'package:poddr/components/inputField.dart';

class SearchPage extends ConsumerStatefulWidget {
  SearchPage({Key? key, this.query = ""}) : super(key: key);

  final Search podcastSearch = Search();
  String query;

  @override
  ConsumerState<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  SearchResult result = SearchResult();
  bool isLoading = false;
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      child: LayoutBuilder(builder: (context, constraints) {
        return Column(
          children: [
            const Header(title: 'Search'),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: CustomInputField(
                hint: "Search",
                autofocus: true,
                textController: searchController,
                onChanged: (value) {
                  searchController.text = value;
                },
                onSubmitted: (value) {
                  print("Submitted value: $value");
                  search(value);
                },
              ),
            ),
            Text(searchController.text),
            Expanded(
              child: ListView(
                  children: List.generate(result.resultCount, (index) {
                final Item podcast = result.items[index];
                return GestureDetector(
                  onTap: () {
                    debugPrint("Clicked ${podcast.feedUrl}");
                    context.go('/podcast?podcastUrl=${podcast.feedUrl}');
                  },
                  child: Card(
                    child: ListTile(
                      leading: Image.network(podcast.bestArtworkUrl ?? ""),
                      title: Text(podcast.artistName ?? "Artist"),
                      subtitle: Text(podcast.trackName ?? "Track"),
                    ),
                  ),
                );
              })),
            )
          ],
        );
      }),
    );
  }

  void search(query) async {
    SearchResult sr = await widget.podcastSearch.search(query);
    inspect(sr);
    setState(() {
      result = sr;
    });
  }
}
