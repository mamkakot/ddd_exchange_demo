import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_ddd/application/auth/auth_bloc.dart';

import '../../injection.dart';
import '../routes/router.dart';

class AppWidget extends StatelessWidget {
  final _appRouter = AppRouter();

  AppWidget({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            return getIt<AuthBloc>()..add(const AuthEvent.authCheckRequested());
          },
        )
      ],
      child: MaterialApp.router(
        title: 'Тестовое приложение по заявкам',
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: const Color.fromARGB(255, 0, 161, 153),
          buttonTheme: const ButtonThemeData(
              buttonColor: Color.fromARGB(255, 0, 161, 153)),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 0, 161, 153),
                  minimumSize: const Size.fromHeight(35))),
          // Define the default font family.
          fontFamily: 'Montserrat',

          // Define the default `TextTheme`. Use this to specify the default
          // text styling for headlines, titles, bodies of text, and more.
          textTheme: const TextTheme(
              displayLarge:
                  TextStyle(fontSize: 42, fontWeight: FontWeight.bold),
              titleLarge: TextStyle(fontSize: 24),
              bodyMedium: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
              bodySmall: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              labelLarge: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              labelSmall: TextStyle(
                fontSize: 12,
                color: Colors.black,
              ),
              labelMedium: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              )),
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: const BorderSide(
                  width: 1,
                  color: Colors.black,
                )),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 3.0),
            fillColor: Colors.white,
            filled: true,
          ),
          // floatingActionButtonTheme: FloatingActionButtonThemeData(
          //   backgroundColor: Colors.blue[900],
          // ),
        ),
        debugShowCheckedModeBanner: false,
        routerDelegate: _appRouter.delegate(),
        routeInformationParser: _appRouter.defaultRouteParser(),
      ),
    );
  }
}
