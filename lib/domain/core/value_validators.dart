import 'package:dartz/dartz.dart';
import '../core/failures.dart';

Either<ValueFailure<String>, String> validateMaxLength(
    String input, int maxLength) {
  if (input.length <= maxLength) {
    return right(input);
  } else {
    return left(
        ValueFailure.valueTooLong(failedValue: input, maxLength: maxLength));
  }
}

Either<ValueFailure<String>, String> validateStringNotEmpty(String input) {
  if (input.isNotEmpty) {
    return right(input);
  } else {
    return left(ValueFailure.empty(failedValue: input));
  }
}

Either<ValueFailure<int>, int> validateTimeSpan(
    DateTime start, DateTime end, int minMinutes) {
  final difference = end.difference(start).inMinutes;
  if (difference >= minMinutes) {
    return right(difference);
  } else {
    return left(
        ValueFailure.shortTimeSpan(failedValue: difference, min: minMinutes));
  }
}

Either<ValueFailure<double>, double> validateMaxHours(
    double input, double maxHours) {
  if (input <= maxHours) {
    return right(input);
  } else {
    return left(ValueFailure.tooMuchHours(failedValue: input, max: maxHours));
  }
}

Either<ValueFailure<double>, double> validateMinHours(
    double input, double minHours) {
  if (input > minHours) {
    return right(input);
  } else {
    return left(ValueFailure.tooLittleHours(failedValue: input, min: minHours));
  }
}

Either<ValueFailure<double>, double> validateMaxWorkerRating(
    double input, double maxWorkerRating) {
  if (input <= maxWorkerRating) {
    return right(input);
  } else {
    return left(ValueFailure.tooMuchWorkerRating(
        failedValue: input, max: maxWorkerRating));
  }
}

Either<ValueFailure<double>, double> validateMinWorkerRating(
    double input, double minWorkerRating) {
  if (input > minWorkerRating) {
    return right(input);
  } else {
    return left(ValueFailure.tooLittleWorkerRating(
        failedValue: input, min: minWorkerRating));
  }
}

Either<ValueFailure<int>, int> validateMaxRating(int input, int maxRating) {
  if (input <= maxRating) {
    return right(input);
  } else {
    return left(ValueFailure.tooMuchRating(failedValue: input, max: maxRating));
  }
}

Either<ValueFailure<int>, int> validateMinRating(int input, int minRating) {
  if (input >= minRating) {
    return right(input);
  } else {
    return left(
        ValueFailure.tooLittleRating(failedValue: input, min: minRating));
  }
}

Either<ValueFailure<String>, String> validateEmailAddress(String input) {
  const emailRegex =
      r"""^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+""";
  if (RegExp(emailRegex).hasMatch(input)) {
    return right(input);
  } else {
    return left(ValueFailure.invalidEmail(failedValue: input));
  }
}

Either<ValueFailure<String>, String> validateUsername(String input) {
  if (input.length <= 150) {
    return right(input);
  } else {
    return left(ValueFailure.invalidEmail(failedValue: input));
  }
}

Either<ValueFailure<String>, String> validatePassword(String input) {
  if (input.length >= 8) {
    return right(input);
  } else {
    return left(ValueFailure.shortPassword(failedValue: input));
  }
}

Either<ValueFailure<String>, String> validateUserCode(
    String input, int length) {
  const codeRegex = r"""^[0-9]+$""";
  if (RegExp(codeRegex).hasMatch(input) && input.length == length) {
    return right(input);
  } else {
    return left(ValueFailure.invalidWorkerCodeLength(
      failedValue: input,
      exactLength: length,
    ));
  }
}
