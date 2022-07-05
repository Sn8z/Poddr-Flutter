import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  final String query;

  const SearchPage({Key? key, this.query = ""}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text("Search"),
        Text(query),
        ElevatedButton(
          onPressed: () {
            String test = "test";
            print(test);
          },
          child: const Text("Test"),
        ),
      ],
    );
  }
}
