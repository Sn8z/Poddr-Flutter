import 'package:flutter/material.dart';
import 'package:poddr/components/inputField.dart';
import 'package:podcast_search/podcast_search.dart';

class SearchPage extends StatefulWidget {
  final String query;
  final Search search = Search();
  bool isLoading = false;

  SearchPage({Key? key, this.query = ""}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    return Column(
      children: [
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
        Text(widget.query),
      ],
    );
  }

  void search(String query) async {
    final SearchResult result = await widget.search.search(query);
    print(result);
  }
}
