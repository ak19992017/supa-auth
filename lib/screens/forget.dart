import 'package:flutter/material.dart';
import 'package:supa_auth/constants/constants.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          if (MediaQuery.of(context).size.width > 700)
            Expanded(flex: 3, child: Container(color: Colors.black)),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Forgot Password',
                    style: Theme.of(context)
                        .textTheme
                        .headline5!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    'Provide your email and we will send you a link to reset your password',
                  ),
                  spacer,
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                        labelText: 'Email', hintText: 'Enter a valid email'),
                    validator: (String? value) {
                      if (value!.isEmpty || !value.contains('@')) {
                        return 'Email is not valid';
                      } else {
                        return null;
                      }
                    },
                  ),
                  spacer,
                  SuperButton(
                    text: 'Send recovery link',
                    onTap: () {},
                    width: MediaQuery.of(context).size.width,
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Go Back'),
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
