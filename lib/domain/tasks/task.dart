import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hello_ddd/domain/core/value_objects.dart';
import 'package:hello_ddd/domain/tasks/value_objects.dart';

import '../core/failures.dart';

part 'task.freezed.dart';

@freezed
class Task with _$Task {
  const Task._();

  const factory Task({
    required UniqueId id,
    required TaskName name,
    required TaskType type,
  }) = _Task;

  factory Task.empty() => Task(
        id: UniqueId(),
        name: TaskName(''),
        type: TaskType(TaskType.predefinedTypes.first),
      );
}

extension FailureOption on Task {
  Option<ValueFailure<dynamic>> get failureOption {
    return name.failureOrUnit
        .andThen(type.failureOrUnit)
        .fold((l) => some(l), (_) => none());
  }
}
