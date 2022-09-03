import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SuperbaseCredentials {
  static const String url = "https://sjtwdliejlnzuxdkvcww.supabase.co ";
  static const String key =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InNqdHdkbGllamxuenV4ZGt2Y3d3Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2NjIwMTA0MzQsImV4cCI6MTk3NzU4NjQzNH0.0z5gYHmDMR0NG8A02T4rLtTK0XOGzdzNefs5B98Jox0";

  static SupabaseClient supabaseClient = SupabaseClient(url, key);
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
