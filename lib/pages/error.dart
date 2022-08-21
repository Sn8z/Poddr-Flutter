import 'package:flutter/material.dart';
import 'package:poddr/components/base.dart';

class ErrorPage extends StatelessWidget {
  final Exception error;
  const ErrorPage({Key? key, required this.error}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      child: SelectableText(
        error.toString(),
      ),
    );
  }
}
