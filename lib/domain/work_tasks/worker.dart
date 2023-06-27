import 'package:freezed_annotation/freezed_annotation.dart';

import '../auth/user.dart';
import '../auth/value_objects.dart';

part 'worker.freezed.dart';

@freezed
class Worker with _$Worker {
  const factory Worker({
    required User user,
    required WorkerName fullName,
    required WorkerCode code,
    required WorkerPosition position
  }) = _Worker;
}
// required UserName fullName,
// required UserCode code,
// required UserPosition position
