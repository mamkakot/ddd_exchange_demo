import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hello_ddd/presentation/pages/sign_in_page/sign_in_page.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hello DDD!',
      theme: ThemeData.light().copyWith(
        primaryColor: Colors.green[800],
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      home: const SignInPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
