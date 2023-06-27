import 'package:freezed_annotation/freezed_annotation.dart';

part 'failures.freezed.dart';

@freezed
class ValueFailure<T> with _$ValueFailure<T> {
  const factory ValueFailure.shortTimeSpan({
    required T failedValue,
    required int min,
  }) = ShortTimeSpan<T>;

  const factory ValueFailure.valueTooLong({
    required T failedValue,
    required int maxLength,
  }) = ValueTooLong<T>;

  const factory ValueFailure.tooMuchHours({
    required T failedValue,
    required double max,
  }) = TooMuchHours<T>;

  const factory ValueFailure.tooLittleHours({
    required T failedValue,
    required double min,
  }) = TooLittleHours<T>;

  const factory ValueFailure.empty({
    required T failedValue,
  }) = Empty<T>;

  const factory ValueFailure.invalidWorkerCodeLength({
    required T failedValue,
    required int exactLength,
  }) = InvalidWorkerCodeLength<T>;

  const factory ValueFailure.invalidEmail({
    required T failedValue,
  }) = InvalidEmail<T>;

  const factory ValueFailure.shortPassword({
    required T failedValue,
  }) = ShortPassword<T>;
}
