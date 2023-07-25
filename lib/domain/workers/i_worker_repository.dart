import 'package:dartz/dartz.dart';
import 'package:hello_ddd/domain/workers/worker.dart';
import 'package:hello_ddd/domain/workers/worker_failure.dart';

abstract class IWorkerRepository {
  Stream<Either<WorkerFailure, List<Worker>>> watchAll();

  Future<Either<WorkerFailure, Unit>> create(Worker workTask);

  Future<Either<WorkerFailure, Unit>> update(Worker workTask);

  Future<Either<WorkerFailure, Unit>> delete(Worker workTask);
}
