// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:supa_auth/constants/constants.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome back',
              style: Theme.of(context)
                  .textTheme
                  .headline5!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(labelText: 'Email'),
                    keyboardType: TextInputType.emailAddress,
                    validator: (String? value) {
                      if (value!.isEmpty || !value.contains('@')) {
                        return 'Email is not valid';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(labelText: 'Password'),
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'Invalid password';
                      }
                      return null;
                    },
                  )
                ],
              ),
            ),
            TextButton(
                onPressed: () => Navigator.pushNamed(context, '/forget'),
                child: const Text('Forgot Password?')),
            spacer,
            SuperButton(
              text: _isLoading ? "Loading" : 'Sign In',
              onTap: _isLoading
                  ? null
                  : () async {
                      if (_formKey.currentState!.validate()) {
                        signInUser(
                          email: emailController.text,
                          password: passwordController.text,
                        );
                      }
                    },
              width: MediaQuery.of(context).size.width,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Don\'t have an account?'),
                TextButton(
                    onPressed: () => Navigator.pushNamed(context, '/register'),
                    child: const Text('Register'))
              ],
            ),
          ],
        ),
      ),
    );
  }

  void signInUser({required String email, required String password}) async {
    setState(() {
      _isLoading = true;
    });
    try {
      GotrueSessionResponse response =
          await SuperbaseCredentials.supabaseClient.auth.signIn(
        email: email,
        password: password,
        options: const AuthOptions(
          redirectTo:
              kIsWeb ? null : 'io.supabase.flutterquickstart://login-callback/',
        ),
      );
      emailController.clear();
      passwordController.clear();

      String? userEmail = response.user!.email;
      print("SignIn Successful : $userEmail");

      Navigator.pushReplacementNamed(context, '/home');
    } catch (error) {
      _showDialog(context, title: 'Error', message: error.toString());
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _showDialog(context, {String? title, String? message}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title ?? ''),
        content: SelectableText(message ?? ''),
        actions: <Widget>[
          MaterialButton(
            child: const Text("Close"),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}
