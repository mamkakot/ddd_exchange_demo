import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hello_ddd/domain/core/value_objects.dart';
import '../workers/value_objects.dart';

part 'worker.freezed.dart';

@freezed
class Worker with _$Worker {
  const factory Worker({
    required UniqueId id,
    // required User user,
    required WorkerFullName fullName,
    required WorkerCode? code,
    required WorkerPosition position,
    required WorkerRating? rating,
    required WorkerRole role,
  }) = _Worker;
}
