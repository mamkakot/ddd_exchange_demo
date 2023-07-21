import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_ddd/application/auth/auth_bloc.dart';
import 'package:hello_ddd/injection.dart';
import 'package:hello_ddd/presentation/routes/router.dart';

@RoutePage()
class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return getIt<AuthBloc>()..add(const AuthEvent.authCheckRequested());
      },
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          state.when(
              initial: () {},
              authenticated: () =>
                  context.router.replace(const RoleSelectionRoute()),
              unauthenticated: () =>
                  context.router.replace(const SignInRoute()));
        },
        child: const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
