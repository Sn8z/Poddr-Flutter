import 'package:flutter/material.dart';
import 'package:poddr/services/auth_service.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatelessWidget {
  SignInPage({Key? key}) : super(key: key);

  String email = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              color: Theme.of(context).primaryColor,
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(250.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Log In"),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) {
                      email = value.toString().trim();
                    },
                    textAlign: TextAlign.start,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Enter email',
                    ),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    onChanged: (value) {
                      password = value.toString().trim();
                    },
                    textAlign: TextAlign.start,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Enter password',
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      String test = "signin";
                      Provider.of<AuthService>(context, listen: false)
                          .signIn(email, password);
                      print(test);
                    },
                    child: const Text("Sign In"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      String test = "signin";
                      Provider.of<AuthService>(context, listen: false)
                          .signInAnonymously();
                      print(test);
                    },
                    child: const Text("Sign In Anonymously",
                        overflow: TextOverflow.ellipsis),
                  ),
                  const Text("- Or -"),
                  ElevatedButton(
                    onPressed: () {
                      String test = "register";
                      print(test);
                    },
                    child: const Text("Register"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
