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


class WorkerFullName extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  static const maxLength = 300;

  factory WorkerFullName(String input) {
    return WorkerFullName._(
      validateMaxLength(input, maxLength).flatMap(validateStringNotEmpty),
    );
  }

  const WorkerFullName._(this.value);
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
class WorkerRating extends ValueObject<double> {
  @override
  final Either<ValueFailure<double>, double> value;

  static const maxRating = 5.0;
  static const minRating = 0.0;

  factory WorkerRating(double input) {
    return WorkerRating._(
      validateMaxWorkerRating(input, maxRating)
          .flatMap((val) => validateMinWorkerRating(val, minRating)),
    );
  }

  const WorkerRating._(this.value);
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
