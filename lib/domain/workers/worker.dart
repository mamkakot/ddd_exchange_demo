import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hello_ddd/domain/core/value_objects.dart';
import '../auth/user.dart';
import '../core/failures.dart';
import '../workers/value_objects.dart';

part 'worker.freezed.dart';

@freezed
class Worker with _$Worker {
  const factory Worker({
    required UniqueId id,
    required User? user,
    required WorkerFullName fullName,
    required WorkerPosition position,
    required WorkerRating rating,
  }) = _Worker;

  factory Worker.empty() {
    return Worker(
      id: UniqueId(),
      fullName: WorkerFullName(""),
      position: WorkerPosition(""),
      rating: WorkerRating(0.0),
      user: null,
    );
  }
}

extension FailureOption on Worker {
  Option<ValueFailure<dynamic>> get failureOption {
    return fullName.failureOrUnit
        .andThen(position.failureOrUnit)
        .andThen(rating.failureOrUnit)
        .fold((l) => some(l), (_) => none());
  }
}
