import 'package:flutter/material.dart';
import 'package:supa_auth/constants/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final user = SuperbaseCredentials.supabaseClient.auth.currentUser;

  @override
  void initState() {
    super.initState();
    if (user == null) {
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/signin', (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text(user!.email.toString()),
          SuperButton(
            text: 'LogOut',
            onTap: () => logOut(context),
            width: double.infinity,
          ),
        ],
      ),
    );
  }

  Future<void> logOut(context) async {
    try {
      await SuperbaseCredentials.supabaseClient.auth.signOut();
    } catch (error) {
      context.showErrorSnackBar(message: error.toString());
    }
  }
}
