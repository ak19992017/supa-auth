import 'package:flutter/material.dart';
import 'package:supa_auth/constants/constants.dart';
import 'package:supa_auth/screens/forget.dart';
import 'package:supa_auth/screens/home.dart';
import 'package:supa_auth/screens/register.dart';
import 'package:supa_auth/screens/sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: SuperbaseCredentials.url,
    anonKey: SuperbaseCredentials.key,
  );
  runApp(const Core());
}

class Core extends StatelessWidget {
  const Core({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Supabase.instance.client.auth.onAuthStateChange((event, session) {
      switch (event) {
        case AuthChangeEvent.signedIn:
          Navigator.of(context)
              .pushNamedAndRemoveUntil('/home', (route) => false);
          break;
        case AuthChangeEvent.signedOut:
          Navigator.of(context)
              .pushNamedAndRemoveUntil('/signin', (route) => false);
          break;
        default:
          break;
      }
    }).data;
    return MaterialApp(
      title: 'Supabase Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Poppins', primarySwatch: Colors.green),
      initialRoute: Supabase.instance.client.auth.currentUser != null
          ? '/home'
          : '/signin',
      routes: {
        '/': (_) => const SignInScreen(),
        '/signin': (_) => const SignInScreen(),
        '/register': (_) => const RegisterScreen(),
        '/home': (_) => const HomeScreen(),
        '/forget': (_) => const ForgetPasswordScreen()
      },
    );
  }
}
