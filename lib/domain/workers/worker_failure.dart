import 'package:freezed_annotation/freezed_annotation.dart';

part 'worker_failure.freezed.dart';

@freezed
class WorkerFailure with _$WorkerFailure {
  const factory WorkerFailure.unexpected() = _Unexpected;
  const factory WorkerFailure.insufficientPermission() = _InsufficientPermission;
  const factory WorkerFailure.unableToUpdate() = _UnableToUpdate;
}