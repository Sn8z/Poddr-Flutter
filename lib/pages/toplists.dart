import 'package:flutter/material.dart';
import 'package:poddr/components/header.dart';

class ToplistPage extends StatelessWidget {
  const ToplistPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Header(),
          Expanded(
            child: Text("Toplists"),
          )
        ],
      ),
    );
  }
}
