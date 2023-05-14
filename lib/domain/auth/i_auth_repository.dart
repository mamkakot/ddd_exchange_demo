import 'package:dartz/dartz.dart';
import 'package:hello_ddd/domain/auth/auth_failure.dart';
import 'package:hello_ddd/domain/auth/value_objects.dart';

abstract class IAuthRepository {
  Future<Either<AuthFailure, Unit>> registerWithCredentials({
    required EmailAddress emailAddress,
    required Password password,
  });

  Future<Either<AuthFailure, Unit>> signInWithCredentials({
    required EmailAddress emailAddress,
    required Password password,
  });

  Future<Either<AuthFailure, Unit>> signInWithGoogle();
}
