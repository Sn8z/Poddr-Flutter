import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poddr/components/inputButton.dart';
import 'package:poddr/components/inputField.dart';
import 'package:poddr/helpers/breakpoints.dart';
import 'package:poddr/services/auth_service.dart';
import 'package:poddr/services/snackbar_service.dart';
import 'package:go_router/go_router.dart';

class SignInPage extends ConsumerStatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  ConsumerState<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends ConsumerState<SignInPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(
                        left: 150.0,
                        right: 150.0,
                      ),
                      child: LoginForm(),
                    ),
                  ],
                ),
              ),
            ],
          );
        } else {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Padding(
                padding: EdgeInsets.all(80.0),
                child: LoginForm(),
              ),
            ],
          );
        }
      }),
    );
  }

  Widget buildLoginButton(String email, String password, WidgetRef ref) {
    return ElevatedButton(
      onPressed: () {
        print('UI Signin');
        ref.read(authProvider).signIn(email, password);
      },
      child: const Text("Sign In"),
    );
  }
}

class LoginForm extends ConsumerStatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginForm> createState() => LoginFormState();
}

class LoginFormState extends ConsumerState<LoginForm> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            "Log In",
            style: Theme.of(context).textTheme.headline5,
          ),
          const SizedBox(height: 40),
          CustomInputField(
            label: "Email",
            prefixIcon: const Icon(Icons.email_outlined),
            textController: emailController,
            onChanged: (value) {
              emailController.text = value.toString().trim();
            },
            onSubmitted: (value) {
              login();
            },
          ),
          const SizedBox(
            height: 20,
          ),
          CustomInputField(
            label: "Password",
            prefixIcon: const Icon(Icons.password_outlined),
            textController: passwordController,
            keyboardType: TextInputType.visiblePassword,
            isPassword: true,
            onChanged: (value) {
              passwordController.text = value.toString().trim();
            },
            onSubmitted: (value) {
              login();
            },
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {
              print('UI Sign In with Email/PW');
              login();
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
          const CustomButton(),
          ElevatedButton(
            onPressed: () {
              SnackbarService().successSnack(context);
            },
            child: Text("Snack"),
          ),
          TextButton(
            onPressed: () {
              context.go('/');
            },
            child: const Text('Continue without logging in'),
          )
        ],
      ),
    );
  }

  void login() {
    ref
        .read(authProvider)
        .signIn(emailController.text, passwordController.text);
  }
}
