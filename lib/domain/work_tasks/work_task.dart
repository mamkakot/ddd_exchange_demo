import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hello_ddd/domain/core/value_objects.dart';
import 'package:hello_ddd/domain/work_tasks/store.dart';
import 'package:hello_ddd/domain/work_tasks/value_objects.dart';

import '../core/failures.dart';

part 'work_task.freezed.dart';

@freezed
class WorkTask with _$WorkTask {
  const WorkTask._();

  const factory WorkTask({
    required UniqueId id,
    required WorkTaskName name,
    required WorkTaskType type,
    required Store store,
    required WorkTaskHours hours,
    required WorkTaskBegin beginHour,
    required WorkTaskEnd endHour,
    // required Worker author,
    // required Worker executor,
    required WorkTaskDescription description,
  }) = _WorkTask;

  factory WorkTask.empty() => WorkTask(
        id: UniqueId(),
        name: WorkTaskName(''),
        type: WorkTaskType(WorkTaskType.predefinedTypes.first),
        store: Store.defaultStore(),
        hours: WorkTaskHours(0.0),
        beginHour: WorkTaskBegin(DateTime.now()),
        endHour: WorkTaskEnd(DateTime.now().add(const Duration(hours: 1))),
        description: WorkTaskDescription(''),
      );
}

extension FailureOption on WorkTask {
  Option<ValueFailure<dynamic>> get failureOption {
    return name.failureOrUnit
        .andThen(type.failureOrUnit)
        .fold((l) => some(l), (_) => none());
  }
}
