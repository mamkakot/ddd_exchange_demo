import 'package:dartz/dartz.dart';
import 'package:hello_ddd/domain/core/value_validators.dart';

import '../core/failures.dart';
import '../core/value_objects.dart';

class WorkTaskName extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  static const maxLength = 128;

  factory WorkTaskName(String input) {
    return WorkTaskName._(
      validateMaxLength(input, maxLength).flatMap(validateStringNotEmpty),
    );
  }

  const WorkTaskName._(this.value);
}

class WorkTaskDescription extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  static const maxLength = 500;

  factory WorkTaskDescription(String input) {
    return WorkTaskDescription._(
      validateMaxLength(input, maxLength),
    );
  }

  const WorkTaskDescription._(this.value);
}

class WorkTaskBegin extends ValueObject<DateTime> {
  @override
  final Either<ValueFailure<DateTime>, DateTime> value;

  factory WorkTaskBegin(DateTime input) {
    return WorkTaskBegin._(
      right(input),
    );
  }

  const WorkTaskBegin._(this.value);
}

class WorkTaskEnd extends ValueObject<DateTime> {
  @override
  final Either<ValueFailure<DateTime>, DateTime> value;

  factory WorkTaskEnd(DateTime input) {
    return WorkTaskEnd._(
      right(input),
    );
  }

  const WorkTaskEnd._(this.value);
}

class WorkTaskHours extends ValueObject<double> {
  @override
  final Either<ValueFailure<double>, double> value;

  static const double minHours = 0;
  static const double maxHours = 24;
  static const increment = 0.5;

  factory WorkTaskHours(double input) {
    return WorkTaskHours._(
      validateMaxHours(input, maxHours)
          .flatMap((val) => validateMinHours(val, minHours)),
    );
  }

  const WorkTaskHours._(this.value);
}

class WorkTaskRating extends ValueObject<int> {
  @override
  final Either<ValueFailure<int>, int> value;

  static const int minRating = 0;
  static const int maxRating = 5;

  factory WorkTaskRating(int input) {
    return WorkTaskRating._(
      validateMaxRating(input, maxRating)
          .flatMap((val) => validateMinRating(val, minRating)),
    );
  }

  const WorkTaskRating._(this.value);
}

class WorkTaskType extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  // TODO: remove hardcoded values
  static const List<String> predefinedTypes = [
    'Работа на кассе',
    'Работа КСО (касса самообслуживания)',
    'Работа на кассе и гастроном',
    'Работа на кассе и выкладка',
    'Выкладка товара',
    'Выкладка товара отдел ФРОВ',
    'Выкладка товара молочный отдел',
    'Выкладка товара вино-водочный отдел',
    'Выкладка товара отдел бакалея',
    'Выкладка товара отдел заморозка',
    'Обслуживание в отделах прямого обслуживания',
    'Гастроном (салаты)',
    'Гастроном (рыба)',
    'Гастроном (хлеб)',
    'Погрузочно-разгрузочные работы',
    'Продавец-универсал (только для минидудов)',
  ];

  factory WorkTaskType(String input) {
    return WorkTaskType._(
      right(input),
    );
  }

  factory WorkTaskType.fromUniqueString(String uniqueString) {
    return WorkTaskType._(right(uniqueString));
  }

  const WorkTaskType._(this.value);
}

class StoreName extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  static const maxLength = 128;

  factory StoreName(String input) {
    return StoreName._(
      validateMaxLength(input, maxLength).flatMap(validateStringNotEmpty),
    );
  }

  const StoreName._(this.value);
}

class StoreAddress extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  static const maxLength = 128;

  factory StoreAddress(String input) {
    return StoreAddress._(
      validateStringNotEmpty(input),
    );
  }

  const StoreAddress._(this.value);
}
