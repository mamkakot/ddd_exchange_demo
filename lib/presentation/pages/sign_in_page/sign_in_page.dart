import 'package:flutter/material.dart';
import 'package:hello_ddd/application/auth/sign_in_form/sign_in_form_bloc.dart';
import 'package:hello_ddd/presentation/pages/sign_in_page/widgets/sign_in_form.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../injection.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign in'),
      ),
      body: BlocProvider(
          create: (context) => getIt<SignInFormBloc>(),
          child: const SignInForm()),
    );
  }
}
