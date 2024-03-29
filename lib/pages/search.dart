import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:podcast_search/podcast_search.dart';
import 'package:poddr/components/base.dart';
import 'package:poddr/components/header.dart';
import 'package:poddr/components/inputField.dart';
import 'package:poddr/services/audio_service.dart';

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
                  debugPrint("Submitted value: $value");
                  search(value);
                },
              ),
            ),
            Expanded(
              child: ListView(
                  children: List.generate(result.resultCount, (index) {
                final Item podcast = result.items[index];
                return GestureDetector(
                  onTap: () {
                    debugPrint("Clicked ${podcast.feedUrl}");
                    context.push('/podcast?podcastUrl=${podcast.feedUrl}');
                  },
                  child: Card(
                    child: ListTile(
                      leading: CachedNetworkImage(
                        imageUrl:
                            podcast.artworkUrl100 ?? podcast.artworkUrl ?? "",
                        fit: BoxFit.contain,
                        errorWidget: (context, url, error) {
                          return Image.asset('assets/images/placeholder.png');
                        },
                        placeholder: (context, url) {
                          return const CircularProgressIndicator();
                        },
                      ),
                      title: Text(
                        podcast.artistName ?? "Artist",
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        podcast.trackName ?? "Track",
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      trailing: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.favorite_border_rounded),
                      ),
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
