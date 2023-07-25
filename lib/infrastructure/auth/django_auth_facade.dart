import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:hello_ddd/domain/auth/auth_failure.dart';
import 'package:hello_ddd/domain/auth/i_auth_repository.dart';
import 'package:hello_ddd/domain/auth/value_objects.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hello_ddd/infrastructure/services/local/share_preferences_service.dart';
import 'package:injectable/injectable.dart';
import 'package:http/http.dart' as http;
import '../../domain/auth/user.dart';
import '../work_tasks/work_task_dtos.dart';

@LazySingleton(as: IAuthRepository, env: [Environment.prod])
class DjangoAuthFacade implements IAuthRepository {
  final SharedPreferencesService _preferences;
  final GoogleSignIn _googleSignIn;

  DjangoAuthFacade(
    this._preferences,
    this._googleSignIn,
  );

  @override
  Future<Option<User>> getSignedInUser() async {
    // TODO: add error handling
    try {
      var response = await http.get(
        Uri.parse('http://10.0.2.2:8000/users/me/'),
        headers: {'Authorization': 'TOKEN ${_preferences.token}'},
      );
      var userJson = json.decode(utf8.decode(response.bodyBytes));
      return optionOf(UserDTO.fromJson(userJson).toDomain());
    } on TypeError catch (_) {
      return optionOf(null);
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> registerWithCredentials(
      {required EmailAddress emailAddress, required Password password}) async {
    final emailString = emailAddress.getOrCrash();
    final passwordString = password.getOrCrash();

    // add error handling
    var response = await http.post(
      Uri.parse('http://10.0.2.2:8000/api-token-auth/'),
      body: jsonEncode(<String, String>{
        'username': emailString,
        'password': passwordString,
      }),
    );
    var tokenJson = json.decode(utf8.decode(response.bodyBytes));
    _preferences.saveNewToken(tokenJson);
    return right(unit);
  }

  @override
  Future<Either<AuthFailure, Unit>> signInWithCredentials(
      {required EmailAddress emailAddress, required Password password}) async {
    final emailString = emailAddress.getOrCrash();
    final passwordString = password.getOrCrash();

    // add error handling
    var response = await http.post(
      Uri.parse('http://10.0.2.2:8000/api-token-auth/'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': emailString,
        'password': passwordString,
      }),
    );
    var tokenJson = json.decode(utf8.decode(response.bodyBytes));
    _preferences.saveNewToken(tokenJson['token']);
    return right(unit);
  }

  @override
  Future<Either<AuthFailure, Unit>> signInWithGoogle() {
    // TODO: implement signInWithGoogle
    throw UnimplementedError();
  }

  @override
  Future<void> signOut() => Future.wait([_preferences.removeToken()]);
}
