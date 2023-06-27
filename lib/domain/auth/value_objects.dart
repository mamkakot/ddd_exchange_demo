import 'package:dartz/dartz.dart';

import '../core/failures.dart';
import '../core/value_objects.dart';
import '../core/value_validators.dart';

class EmailAddress extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  factory EmailAddress(String input) {
    return EmailAddress._(
      validateEmailAddress(input),
    );
  }

  const EmailAddress._(this.value);
}

class Password extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  factory Password(String input) {
    return Password._(
      validatePassword(input),
    );
  }

  const Password._(this.value);
}


class WorkerName extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  static const maxLength = 300;

  factory WorkerName(String input) {
    return WorkerName._(
      validateMaxLength(input, maxLength).flatMap(validateStringNotEmpty),
    );
  }

  const WorkerName._(this.value);
}

class WorkerCode extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  static const exactLength = 6;

  factory WorkerCode(String input) {
    return WorkerCode._(
      validateUserCode(input, exactLength).flatMap(validateStringNotEmpty),
    );
  }

  const WorkerCode._(this.value);
}


class WorkerPosition extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  factory WorkerPosition(String input) {
    return WorkerPosition._(
      right(input),
    );
  }

  const WorkerPosition._(this.value);
}
