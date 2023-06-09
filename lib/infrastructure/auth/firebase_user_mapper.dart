import 'package:hello_ddd/domain/auth/user.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import '../../domain/core/value_objects.dart';

extension FirebaseUserDomainX on auth.User {
  User toDomain() {
    return User(
      id: UniqueId.fromUniqueString(uid),
    );
  }
}
