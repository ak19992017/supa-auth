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
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Core();
  }
}

class Core extends StatelessWidget {
  const Core({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Supabase Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Poppins', primarySwatch: Colors.green),
      initialRoute: '/signin',
      routes: {
        '/signin': (_) => const SignInScreen(),
        '/register': (_) => const RegisterScreen(),
        '/home': (_) => const HomeScreen(),
        '/forget': (_) => const ForgetPasswordScreen()
      },
    );
  }
}
