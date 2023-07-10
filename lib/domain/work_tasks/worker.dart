import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hello_ddd/domain/core/value_objects.dart';

import '../auth/value_objects.dart';

part 'worker.freezed.dart';

@freezed
class Worker with _$Worker {
  const factory Worker({
    required UniqueId id,
    required WorkerFullName fullName,
    required WorkerCode code,
    required WorkerPosition position,
    required WorkerRating rating,
  }) = _Worker;
}
