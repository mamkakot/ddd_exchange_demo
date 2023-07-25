import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hello_ddd/domain/auth/auth_failure.dart';
import 'package:hello_ddd/domain/auth/i_auth_repository.dart';
import 'package:hello_ddd/domain/auth/value_objects.dart';
import 'package:injectable/injectable.dart';

part 'sign_in_form_event.dart';

part 'sign_in_form_state.dart';

part 'sign_in_form_bloc.freezed.dart';

@Injectable()
class SignInFormBloc extends Bloc<SignInFormEvent, SignInFormState> {
  final IAuthRepository _repository;

  SignInFormBloc(this._repository) : super(SignInFormState.initial()) {
    on<SignInFormEvent>((event, emit) async {
      await event.map(
        emailChanged: (e) async {
          emit(state.copyWith(
            emailAddress: EmailAddress(e.emailString),
            authFailureOrSuccessOption: none(),
          ));
        },
        passwordChanged: (e) async {
          emit(state.copyWith(
            password: Password(e.passwordString),
            authFailureOrSuccessOption: none(),
          ));
        },
        registerWithCredentialsPressed: (e) async {
          await _performActionOnAuthRepositoryWithCredentials(
              _repository.registerWithCredentials, emit, e);
        },
        signInWithCredentialsPressed: (e) async {
          await _performActionOnAuthRepositoryWithCredentials(
              _repository.signInWithCredentials, emit, e);
        },
        signInWithGooglePressed: (e) async {
          emit(state.copyWith(
            isSubmitting: true,
            authFailureOrSuccessOption: none(),
          ));
          final result = await _repository.signInWithGoogle();
          emit(state.copyWith(
            isSubmitting: false,
            authFailureOrSuccessOption: some(result),
          ));
        },
      );
    });
  }

  Future<void> _performActionOnAuthRepositoryWithCredentials(
      Future<Either<AuthFailure, Unit>> Function({
        required EmailAddress emailAddress,
        required Password password,
      }) forwardedCall,
      Emitter<SignInFormState> emit,
      SignInFormEvent event) async {
    final isEmailValid = state.emailAddress.isValid();
    final isPasswordValid = state.password.isValid();

    Either<AuthFailure, Unit>? result;

    if (isEmailValid && isPasswordValid) {
      emit(state.copyWith(
        isSubmitting: true,
        authFailureOrSuccessOption: none(),
      ));

      result = await forwardedCall(
          emailAddress: state.emailAddress, password: state.password);
    }

    emit(state.copyWith(
      isSubmitting: false,
      showErrorMessages: true,
      authFailureOrSuccessOption: optionOf(result),
    ));
  }
}
