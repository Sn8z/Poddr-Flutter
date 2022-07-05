import 'package:flutter/material.dart';
import 'package:poddr/services/auth_service.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text("Signin"),
        ElevatedButton(
          onPressed: () {
            String test = "signin";
            Provider.of<AuthService>(context, listen: false)
                .signInAnonymously();
            print(test);
          },
          child: const Text("Sign In"),
        ),
      ],
    );
  }
}
