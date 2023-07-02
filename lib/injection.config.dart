// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:firebase_auth/firebase_auth.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:google_sign_in/google_sign_in.dart' as _i4;
import 'package:injectable/injectable.dart' as _i2;

import 'application/auth/auth_bloc.dart' as _i12;
import 'application/auth/sign_in_form/sign_in_form_bloc.dart' as _i9;
import 'application/work_tasks/work_task_actor/work_task_actor_bloc.dart'
    as _i10;
import 'application/work_tasks/work_task_watcher/work_task_watcher_bloc.dart'
    as _i11;
import 'domain/auth/i_auth_repository.dart' as _i5;
import 'domain/work_tasks/i_work_task_repository.dart' as _i7;
import 'infrastructure/auth/firebase_auth_repository.dart' as _i6;
import 'infrastructure/core/firebase_injectable_module.dart' as _i13;
import 'infrastructure/work_tasks/work_task_repository.dart' as _i8;

const String _prod = 'prod';

extension GetItInjectableX on _i1.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final firebaseInjectableModule = _$FirebaseInjectableModule();
    gh.lazySingleton<_i3.FirebaseAuth>(
        () => firebaseInjectableModule.firebaseAuth);
    gh.lazySingleton<_i4.GoogleSignIn>(
        () => firebaseInjectableModule.googleSignIn);
    gh.lazySingleton<_i5.IAuthRepository>(
      () => _i6.FirebaseAuthRepository(
        gh<_i3.FirebaseAuth>(),
        gh<_i4.GoogleSignIn>(),
      ),
      registerFor: {_prod},
    );
    gh.lazySingleton<_i7.IWorkTaskRepository>(
      () => _i8.WorkTaskRepository(),
      registerFor: {_prod},
    );
    gh.factory<_i9.SignInFormBloc>(
        () => _i9.SignInFormBloc(gh<_i5.IAuthRepository>()));
    gh.factory<_i10.WorkTaskActorBloc>(
        () => _i10.WorkTaskActorBloc(gh<_i7.IWorkTaskRepository>()));
    gh.factory<_i11.WorkTaskWatcherBloc>(
        () => _i11.WorkTaskWatcherBloc(gh<_i7.IWorkTaskRepository>()));
    gh.factory<_i12.AuthBloc>(() => _i12.AuthBloc(gh<_i5.IAuthRepository>()));
    return this;
  }
}

class _$FirebaseInjectableModule extends _i13.FirebaseInjectableModule {}
