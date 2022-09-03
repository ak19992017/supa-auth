import 'package:flutter/cupertino.dart';
import 'package:supa_auth/constants/constants.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
        child: SuperButton(
      text: 'LogOut',
      onTap: () => logout(context),
      width: double.infinity,
    ));
  }

  Future<void> logout(context) async {
    await SuperbaseCredentials.supabaseClient.auth.signOut();
    Navigator.pushNamed(context, 'signin');
  }
}
