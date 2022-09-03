// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supa_auth/constants/authentication.notifier.dart';
import 'package:supa_auth/constants/constants.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AuthenticationNotifier authenticationNotifier =
        context.read<AuthenticationNotifier>();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Register',
              style: Theme.of(context)
                  .textTheme
                  .headline5!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text('Already having an account?'),
                TextButton(
                  onPressed: () => Navigator.pushNamed(context, 'signin'),
                  child: const Text('Sign In'),
                )
              ],
            ),
            spacer,
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                        labelText: 'Email', hintText: 'Enter a valid email'),
                    validator: (String? value) =>
                        (value!.isEmpty || !value.contains('@'))
                            ? 'Email is not valid'
                            : null,
                  ),
                  TextFormField(
                    obscureText: true,
                    controller: _passwordController,
                    decoration: const InputDecoration(
                        labelText: 'Password',
                        hintText: 'Enter secure password'),
                    validator: (String? value) =>
                        value!.isEmpty ? 'Invalid password' : null,
                  ),
                  TextFormField(
                    controller: _confirmPasswordController,
                    decoration: const InputDecoration(
                      labelText: 'Confirm password',
                      hintText: 'Repeat password',
                    ),
                    validator: (String? value) =>
                        (value != _passwordController.text || value!.isEmpty)
                            ? 'Password!=Confirm passsword'
                            : null,
                  ),
                ],
              ),
            ),
            spacer,
            SuperButton(
              text: 'Register',
              onTap: () async {
                if (_formKey.currentState!.validate()) {
                  await authenticationNotifier.signUpUser(
                    context,
                    email: _emailController.text,
                    password: _passwordController.text,
                  );
                }
              },
              width: MediaQuery.of(context).size.width,
            )
          ],
        ),
      ),
    );
  }
}
