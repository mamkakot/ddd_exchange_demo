import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hello_ddd/domain/auth/i_auth_repository.dart';
import 'package:injectable/injectable.dart';

part 'auth_event.dart';

part 'auth_state.dart';

part 'auth_bloc.freezed.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IAuthRepository _authRepository;

  AuthBloc(this._authRepository) : super(const AuthState.initial()) {
    on<AuthEvent>((event, emit) async {
      await event.map(
        authCheckRequested: (e) async {
          final userOption = await _authRepository.getSignedInUser();
          await userOption.fold(
            () async => emit(const AuthState.unauthenticated()),
            (_) async => emit(const AuthState.authenticated()),
          );
        },
        signedOut: (e) async {
          await _authRepository.signOut();
          emit(const AuthState.unauthenticated());
        },
      );
    });
  }
}
