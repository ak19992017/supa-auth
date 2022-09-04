import 'package:flutter/material.dart';
import 'package:supa_auth/constants/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final user = SuperbaseCredentials.supabaseClient.auth.user();

    return Scaffold(
      body: Column(
        children: [
          Text(user!.email.toString()),
          SuperButton(
            text: 'LogOut',
            onTap: () => logout(context),
            width: double.infinity,
          ),
        ],
      ),
    );
  }

  Future<void> logout(context) async {
    await SuperbaseCredentials.supabaseClient.auth.signOut();
  }
}
