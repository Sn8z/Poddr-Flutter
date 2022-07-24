import 'package:flutter/material.dart';

class SnackbarService {
  void successSnack(BuildContext context) {
    final snackBar = SnackBar(
      content: Row(children: const [
        Icon(
          Icons.info_outline_rounded,
          color: Colors.white70,
        ),
        Text(
          "Snack",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ]),
      backgroundColor: Colors.green,
      behavior: SnackBarBehavior.floating,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
