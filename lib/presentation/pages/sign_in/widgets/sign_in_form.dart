import 'package:another_flushbar/flushbar_helper.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_ddd/application/auth/sign_in_form/sign_in_form_bloc.dart';
import 'package:hello_ddd/presentation/routes/router.dart';

class SignInForm extends StatelessWidget {
  const SignInForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInFormBloc, SignInFormState>(
        builder: (context, state) {
      return Form(
        autovalidateMode: state.showErrorMessages
            ? AutovalidateMode.always
            : AutovalidateMode.disabled,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35),
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 7.0, horizontal: 11),
                  child: Text(
                    "Электронная почта",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
                SizedBox(
                  height:
                      state.emailAddress.isValid() || !state.showErrorMessages
                          ? 35
                          : 57,
                  child: TextFormField(
                    maxLines: 1,
                    decoration: InputDecoration(
                      enabledBorder:
                          Theme.of(context).inputDecorationTheme.border,
                    ),
                    autocorrect: false,
                    onChanged: (value) => context
                        .read<SignInFormBloc>()
                        .add(SignInFormEvent.emailChanged(value)),
                    validator: (_) => context
                        .read<SignInFormBloc>()
                        .state
                        .emailAddress
                        .value
                        .fold(
                            (l) => l.maybeMap(
                                invalidEmail: (_) =>
                                    'Неверно указан адрес эл. почты',
                                orElse: () => null),
                            (r) => null),
                  ),
                ),
                const SizedBox(height: 24),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 7.0, horizontal: 11),
                  child: Text(
                    "Пароль",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
                SizedBox(
                  height: state.password.isValid() || !state.showErrorMessages
                      ? 35
                      : 57,
                  child: TextFormField(
                    maxLines: 1,
                    decoration: InputDecoration(
                      enabledBorder:
                          Theme.of(context).inputDecorationTheme.border,
                    ),
                    autocorrect: false,
                    obscureText: true,
                    onChanged: (value) => context
                        .read<SignInFormBloc>()
                        .add(SignInFormEvent.passwordChanged(value)),
                    validator: (_) => context
                        .read<SignInFormBloc>()
                        .state
                        .password
                        .value
                        .fold(
                            (l) => l.maybeMap(
                                shortPassword: (_) => 'Слишком короткий пароль',
                                orElse: () => null),
                            (r) => null),
                  ),
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {
                    context.read<SignInFormBloc>().add(
                        const SignInFormEvent.signInWithCredentialsPressed());
                  },
                  child: const Text('Войти'),
                ),
                ElevatedButton(
                  onPressed: () {
                    context.read<SignInFormBloc>().add(
                        const SignInFormEvent.registerWithCredentialsPressed());
                  },
                  child: const Text('Зарегистрироваться'),
                ),
                ElevatedButton(
                  onPressed: () {
                    context
                        .read<SignInFormBloc>()
                        .add(const SignInFormEvent.signInWithGooglePressed());
                  },
                  child: const Text('Войти с помощью Google'),
                ),
                if (state.isSubmitting) ...[
                  const SizedBox(height: 8),
                  const LinearProgressIndicator(value: null),
                ]
              ],
            ),
          ),
        ),
      );
    }, listener: (context, state) {
      state.authFailureOrSuccessOption.fold(
          () => {},
          (either) => either.fold((failure) {
                FlushbarHelper.createError(
                    message: failure.map(
                  cancelledByUser: (_) => 'Отмена операции',
                  serverError: (e) => 'Ошибка на стороне сервера',
                  invalidCredentials: (_) => 'Неправильные учётные данные',
                  emailAlreadyInUse: (_) => 'Неправильные учётные данные',
                )).show(context);
              }, (_) {
                context.router.replace(const SplashRoute());
              }));
    });
  }
}
