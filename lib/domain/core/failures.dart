import 'package:freezed_annotation/freezed_annotation.dart';

part 'failures.freezed.dart';

@freezed
class ValueFailure<T> with _$ValueFailure<T> {
  // when task time span is too short
  const factory ValueFailure.shortTimeSpan({
    required T failedValue,
    required int min,
  }) = ShortTimeSpan<T>;

  // when task name is too long
  const factory ValueFailure.longName({
    required T failedValue,
    required int max,
  }) = LongName<T>;

  // when task name is empty
  const factory ValueFailure.empty({
    required T failedValue,
  }) = Empty<T>;

  // when email is invalid
  const factory ValueFailure.invalidEmail({
    required T failedValue,
  }) = InvalidEmail<T>;

  // when password is too short
  const factory ValueFailure.shortPassword({
    required T failedValue,
  }) = ShortPassword<T>;
}
