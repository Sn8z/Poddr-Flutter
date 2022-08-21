import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      child: Text("Button"),
      onPressed: () {
        print("Btn pressed");
      },
    );
  }
}
