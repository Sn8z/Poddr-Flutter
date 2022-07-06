import 'package:flutter/material.dart';
import 'package:poddr/services/auth_service.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatelessWidget {
  final String query;

  const SearchPage({Key? key, this.query = ""}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text("Search"),
        Text(query),
      ],
    );
  }
}
