// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i4;
import 'package:firebase_auth/firebase_auth.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:google_sign_in/google_sign_in.dart' as _i5;
import 'package:injectable/injectable.dart' as _i2;

import 'application/auth/auth_bloc.dart' as _i14;
import 'application/auth/sign_in_form/sign_in_form_bloc.dart' as _i10;
import 'application/work_tasks/work_task_actor/work_task_actor_bloc.dart'
    as _i11;
import 'application/work_tasks/work_task_form/work_task_form_bloc.dart' as _i12;
import 'application/work_tasks/work_task_watcher/work_task_watcher_bloc.dart'
    as _i13;
import 'domain/auth/i_auth_repository.dart' as _i6;
import 'domain/work_tasks/i_work_task_repository.dart' as _i8;
import 'infrastructure/auth/firebase_auth_facade.dart' as _i7;
import 'infrastructure/core/firebase_injectable_module.dart' as _i15;
import 'infrastructure/work_tasks/work_task_repository.dart' as _i9;

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
    gh.lazySingleton<_i4.FirebaseFirestore>(
        () => firebaseInjectableModule.firestore);
    gh.lazySingleton<_i5.GoogleSignIn>(
        () => firebaseInjectableModule.googleSignIn);
    gh.lazySingleton<_i6.IAuthRepository>(
      () => _i7.FirebaseAuthFacade(
        gh<_i3.FirebaseAuth>(),
        gh<_i5.GoogleSignIn>(),
      ),
      registerFor: {_prod},
    );
    gh.lazySingleton<_i8.IWorkTaskRepository>(
        () => _i9.WorkTaskRepository(gh<_i4.FirebaseFirestore>()));
    gh.factory<_i10.SignInFormBloc>(
        () => _i10.SignInFormBloc(gh<_i6.IAuthRepository>()));
    gh.factory<_i11.WorkTaskActorBloc>(
        () => _i11.WorkTaskActorBloc(gh<_i8.IWorkTaskRepository>()));
    gh.factory<_i12.WorkTaskFormBloc>(
        () => _i12.WorkTaskFormBloc(gh<_i8.IWorkTaskRepository>()));
    gh.factory<_i13.WorkTaskWatcherBloc>(
        () => _i13.WorkTaskWatcherBloc(gh<_i8.IWorkTaskRepository>()));
    gh.factory<_i14.AuthBloc>(() => _i14.AuthBloc(gh<_i6.IAuthRepository>()));
    return this;
  }
}

class _$FirebaseInjectableModule extends _i15.FirebaseInjectableModule {}
