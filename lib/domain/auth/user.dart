import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hello_ddd/domain/auth/value_objects.dart';
import 'package:hello_ddd/domain/core/value_objects.dart';

part 'user.freezed.dart';

@freezed
class User with _$User {
  const factory User({
    required UniqueId id,
    required Username username,
    required EmailAddress emailAddress,
    // TODO: write ValueObjects for this
    required String firstName,
    required String lastName,
  }) = _User;
}
