import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:podcast_search/podcast_search.dart';
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
    return Column(
      children: [
        Header(title: 'Search'),
        CustomInputField(
          hint: "Search",
          textController: searchController,
          onChanged: (value) {
            searchController.text = value;
          },
          onSubmitted: (value) {
            print("Submitted value: $value");
            search(value);
          },
        ),
        Text(searchController.text),
        Expanded(
          child: ListView(
              children: List.generate(result.resultCount, (index) {
            return Text(result.items[index].artistName!);
          })),
        )
      ],
    );
  }

  void search(query) async {
    SearchResult sr = await widget.podcastSearch.search(query);
    print(sr.toString());
    setState(() {
      result = sr;
    });
  }
}
