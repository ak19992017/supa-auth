import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SuperbaseCredentials {
  static const String url = "https://cgquhuepmjktlajpogdk.supabase.co";
  static const String key =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNncXVodWVwbWprdGxhanBvZ2RrIiwicm9sZSI6ImFub24iLCJpYXQiOjE2NjIyNzA2MDMsImV4cCI6MTk3Nzg0NjYwM30.enGt2KXl1guiSLXp6UteYG5qLsmCojU8EGOITSb_BmM";

  static SupabaseClient supabaseClient = SupabaseClient(url, key);
  final supabase = Supabase.instance.client;
}

// extension ShowSnackBar on BuildContext {
//   void showSnackBar({
//     required String message,
//     Color backgroundColor = Colors.white,
//   }) {
//     ScaffoldMessenger.of(this).showSnackBar(SnackBar(
//       content: Text(message),
//       backgroundColor: backgroundColor,
//       margin: const EdgeInsets.all(8),
//       behavior: SnackBarBehavior.floating,
//     ));
//   }

//   void showErrorSnackBar({required String message}) {
//     showSnackBar(message: message, backgroundColor: Colors.red);
//   }
// }

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
  final Function()? onTap;
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
