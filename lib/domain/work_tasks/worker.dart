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

  factory Worker.defaultWorker() => Worker(
    id: UniqueId(),
    fullName: WorkerFullName("Иванов Иван Иванович"),
    code: WorkerCode("000001"),
    position: WorkerPosition("Грузчик"),
    rating: WorkerRating(4.5),
  );
}
