import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poddr/helpers/breakpoints.dart';
import 'package:poddr/services/auth_service.dart';

class SignInPage extends ConsumerWidget {
  SignInPage({Key? key}) : super(key: key);

  String email = "";

  String password = "";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        if (constraints.maxWidth > Breakpoints.tabletScreen) {
          return Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  color: Theme.of(context).primaryColor,
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 150.0,
                    right: 150.0,
                  ),
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
                          print('UI Signin');
                          ref.read(authProvider).signIn(email, password);
                        },
                        child: const Text("Sign In"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          print('UI Anon signin');
                          ref.read(authProvider).signInAnonymously();
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
          );
        } else {
          return Padding(
            padding: const EdgeInsets.all(80.0),
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
                    // Login
                    print(test);
                  },
                  child: const Text("Sign In"),
                ),
                ElevatedButton(
                  onPressed: () {
                    String test = "signin";
                    // Sign in as Anon
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
          );
        }
      }),
    );
  }
}
