import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hello_ddd/domain/core/value_objects.dart';
import 'package:hello_ddd/domain/work_tasks/store.dart';
import 'package:hello_ddd/domain/work_tasks/value_objects.dart';
import 'package:hello_ddd/domain/workers/worker.dart';
import 'package:hello_ddd/domain/core/failures.dart';

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
    required WorkTaskBegin beginDate,
    required WorkTaskEnd endDate,
    required WorkTaskRating rating,
    required bool completed,
    Worker? worker,
    required WorkTaskDescription description,
  }) = _WorkTask;

  factory WorkTask.empty() {
    return WorkTask(
      id: UniqueId(),
      name: WorkTaskName(''),
      type: WorkTaskType(WorkTaskType.predefinedTypes.first),
      store: Store.predefinedStores.first,
      worker: null,
      hours: WorkTaskHours(8.0),
      beginDate: WorkTaskBegin(DateTime.now()),
      endDate: WorkTaskEnd(DateTime.now().add(const Duration(hours: 1))),
      description: WorkTaskDescription(''),
      completed: false,
      rating: WorkTaskRating(0),
    );
  }
}

extension FailureOption on WorkTask {
  Option<ValueFailure<dynamic>> get failureOption {
    return name.failureOrUnit
        .andThen(type.failureOrUnit)
        .fold((l) => some(l), (_) => none());
  }
}
