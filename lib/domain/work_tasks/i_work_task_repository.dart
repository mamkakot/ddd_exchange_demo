import 'package:dartz/dartz.dart';
import 'package:hello_ddd/domain/work_tasks/work_task.dart';
import 'package:hello_ddd/domain/work_tasks/work_task_failure.dart';

abstract class IWorkTaskRepository {
  Stream<Either<WorkTaskFailure, List<WorkTask>>> watchAll();

  Stream<Either<WorkTaskFailure, List<WorkTask>>> watchUncompleted();

  Future<Either<WorkTaskFailure, Unit>> create(WorkTask workTask);

  Future<Either<WorkTaskFailure, Unit>> update(WorkTask workTask);

  Future<Either<WorkTaskFailure, Unit>> delete(WorkTask workTask);
}
