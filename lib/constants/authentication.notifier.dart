// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:supa_auth/constants/constants.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthenticationNotifier extends ChangeNotifier {
  Future<void> signUpUser(context, {String? email, String? password}) async {
    GotrueSessionResponse response = await SuperbaseCredentials
        .supabaseClient.auth
        .signUp(email!, password!);

    if (response.error == null) {
      String? userEmail = response.data!.user!.email;
      print("SignUp Successful : $userEmail");
      Navigator.pushNamed(context, 'signIn');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("SignUp error : ${response.error!.message}")));
    }
  }

  Future<void> signInUser(context, {String? email, String? password}) async {
    GotrueSessionResponse response =
        await SuperbaseCredentials.supabaseClient.auth.signIn(
            email: email,
            password: password,
            options: AuthOptions(redirectTo: SuperbaseCredentials.url));

    if (response.error == null) {
      String? userEmail = response.data!.user!.email;
      print("SignIn Successful : $userEmail");
      Navigator.pushNamed(context, '/home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("SignIn error : ${response.error!.message}")));
    }
  }
}
