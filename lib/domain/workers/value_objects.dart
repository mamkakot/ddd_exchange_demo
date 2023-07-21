import 'package:dartz/dartz.dart';
import 'package:hello_ddd/domain/core/failures.dart';
import 'package:hello_ddd/domain/core/value_objects.dart';
import 'package:hello_ddd/domain/core/value_validators.dart';

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

class WorkerRole extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  static var predefinedRoles = Roles();

  factory WorkerRole(String val) {
    return WorkerRole._(right(val));
  }

  const WorkerRole._(this.value);
}

class Roles {
  String get worker => 'Исполнитель';

  String get company => 'Компания';

  String get client => 'Заказчик';
}
