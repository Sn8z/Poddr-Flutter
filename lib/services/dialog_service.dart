import 'package:flutter/material.dart';

class DialogService {
  void dialog(BuildContext context) {
    final Dialog dialog = Dialog(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: Colors.red,
        ),
        child: Column(
          children: const [
            Text('Dialog'),
          ],
        ),
      ),
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return dialog;
        });
  }
}
