import 'package:flutter/material.dart';
import 'package:supa_auth/constants/constants.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
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
              'Sign In',
              style: Theme.of(context)
                  .textTheme
                  .headline5!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            Row(children: [
              const Text('Don\'t have an account?'),
              TextButton(
                  onPressed: () => Navigator.pushNamed(context, '/register'),
                  child: const Text('Register'))
            ]),
            spacer,
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
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
                      decoration: const InputDecoration(labelText: 'Password'),
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Invalid password';
                        }
                        return null;
                      },
                    )
                  ],
                )),
            TextButton(
                onPressed: () => Navigator.pushNamed(context, '/forget'),
                child: const Text('Forgot Password?')),
            spacer,
            SuperButton(
              onTap: () async {
                if (_formKey.currentState!.validate()) {
                  await signInUser(
                    email: _emailController.text,
                    password: _passwordController.text,
                  );
                }
              },
              text: 'Sign In',
              width: MediaQuery.of(context).size.width,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> signInUser(
      {required String email, required String password}) async {
    GotrueSessionResponse response = await SuperbaseCredentials
        .supabaseClient.auth
        .signIn(email: email, password: password);

    if (response.data != null) {
      String? userEmail = response.data!.user!.email;
      print("SignIn Successful : $userEmail");
      Navigator.pushReplacementNamed(context, '/home');
    } else if (response.error?.message != null) {
      _showDialog(context, title: 'Error', message: response.error?.message);
    }
  }

  void _showDialog(context, {String? title, String? message}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title ?? ''),
        content: Text(message ?? ''),
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
