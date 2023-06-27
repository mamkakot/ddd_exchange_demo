import 'package:freezed_annotation/freezed_annotation.dart';

part 'work_task_failure.freezed.dart';

@freezed
class WorkTaskFailure with _$WorkTaskFailure {
  const factory WorkTaskFailure.unexpected() = _Unexpected;
}