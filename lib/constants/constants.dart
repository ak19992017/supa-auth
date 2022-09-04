import 'package:flutter/material.dart';
import 'package:supa_auth/screens/home.dart';
import 'package:supa_auth/screens/sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SuperbaseCredentials {
  static const String url = "https://qrclivzvswheqbwpiyyt.supabase.co";
  static const String key =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InFyY2xpdnp2c3doZXFid3BpeXl0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2NjIyMDUyOTUsImV4cCI6MTk3Nzc4MTI5NX0.lcHvN_HKt8PwOqJlNBjRS97Yil8n1SwHFR1C_POel4o';

  static SupabaseClient supabaseClient = SupabaseClient(url, key);
}

class RedirectBasedOnAuthStateState extends SupabaseAuthState {
  @override
  void initState() {
    recoverSupabaseSession();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator();
  }

  @override
  void onAuthenticated(Session session) {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: ((context) => const HomeScreen())),
        (_) => false);
  }

  @override
  void onUnauthenticated() {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: ((context) => const SignInScreen())),
        (_) => false);
  }

  @override
  void onErrorAuthenticating(String message) {}

  @override
  void onPasswordRecovery(Session session) {}
}

extension ShowSnackBar on BuildContext {
  void showSnackBar({
    required String message,
    Color backgroundColor = Colors.white,
  }) {
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: backgroundColor,
      margin: const EdgeInsets.all(8),
      behavior: SnackBarBehavior.floating,
    ));
  }

  void showErrorSnackBar({required String message}) {
    showSnackBar(message: message, backgroundColor: Colors.red);
  }
}

Widget spacer = const SizedBox(height: 20);

class SuperButton extends StatelessWidget {
  const SuperButton({
    Key? key,
    required this.text,
    required this.onTap,
    required this.width,
    this.color = Colors.black,
  }) : super(key: key);
  final String text;
  final Function() onTap;
  final double width;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ElevatedButton(
        onPressed: onTap,
        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(color)),
        child: Text(text),
      ),
    );
  }
}
