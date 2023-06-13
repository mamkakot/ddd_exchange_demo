import 'package:dartz/dartz.dart';
import 'package:hello_ddd/domain/core/value_validators.dart';

import '../core/failures.dart';
import '../core/value_objects.dart';

class TaskName extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  static const maxLength = 128;

  factory TaskName(String input) {
    return TaskName._(
      validateMaxLength(input, maxLength).flatMap(validateStringNotEmpty),
    );
  }

  factory TaskName.fromUniqueString(String uniqueString) {
    return TaskName._(right(uniqueString));
  }

  const TaskName._(this.value);
}

class TaskType extends ValueObject<String> {
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

  factory TaskType(String input) {
    return TaskType._(
      right(input),
    );
  }

  factory TaskType.fromUniqueString(String uniqueString) {
    return TaskType._(right(uniqueString));
  }

  const TaskType._(this.value);
}
