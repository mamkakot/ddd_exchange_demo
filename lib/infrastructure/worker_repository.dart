import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:hello_ddd/domain/workers/i_worker_repository.dart';
import 'package:hello_ddd/domain/workers/worker.dart';
import 'package:hello_ddd/domain/workers/worker_failure.dart';
import 'package:hello_ddd/infrastructure/core/firestore_helpers.dart';
import 'package:hello_ddd/infrastructure/work_tasks/work_task_dtos.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@LazySingleton(as: IWorkerRepository)
class WorkerRepository implements IWorkerRepository {
  final FirebaseFirestore _firestore;

  WorkerRepository(this._firestore);

  @override
  Stream<Either<WorkerFailure, List<Worker>>> watchAll() async* {
    final userDoc = await _firestore.userDocument();

    yield* userDoc.workerCollection
        .snapshots()
        .map(
          (snapshot) => right<WorkerFailure, List<Worker>>(
            snapshot.docs
                .map((doc) => WorkerDTO.fromFirestore(doc).toDomain())
                .toList(),
          ),
        )
        .onErrorReturnWith((e, st) {
      if (e is FirebaseException && e.message!.contains('PERMISSION_DENIED')) {
        print(e.toString());
        return left(const WorkerFailure.insufficientPermission());
      } else {
        print(e.toString());
        return left(const WorkerFailure.unexpected());
      }
    });
  }

  @override
  Future<Either<WorkerFailure, Unit>> create(Worker worker) async {
    try {
      final userDoc = await _firestore.userDocument();
      final workTaskDTO = WorkerDTO.fromDomain(worker);

      await userDoc.workTaskCollection
          .doc(workTaskDTO.id)
          .set(workTaskDTO.toJson());

      return right(unit);
    } on FirebaseException catch (e) {
      if (e.message!.contains('PERMISSION_DENIED')) {
        return left(const WorkerFailure.insufficientPermission());
      } else {
        return left(const WorkerFailure.unexpected());
      }
    }
  }

  @override
  Future<Either<WorkerFailure, Unit>> delete(Worker workTask) async {
    try {
      final userDoc = await _firestore.userDocument();
      final workTaskId = workTask.id.getOrCrash();

      await userDoc.workTaskCollection.doc(workTaskId).delete();

      return right(unit);
    } on FirebaseException catch (e) {
      if (e.message!.contains('PERMISSION_DENIED')) {
        return left(const WorkerFailure.insufficientPermission());
      } else if (e.message!.contains('object-not-found')) {
        return left(const WorkerFailure.unableToUpdate());
      } else {
        return left(const WorkerFailure.unexpected());
      }
    }
  }

  @override
  Future<Either<WorkerFailure, Unit>> update(Worker workTask) async {
    try {
      final userDoc = await _firestore.userDocument();
      final workTaskDTO = WorkerDTO.fromDomain(workTask);

      await userDoc.workTaskCollection
          .doc(workTaskDTO.id)
          .update(workTaskDTO.toJson());

      return right(unit);
    } on FirebaseException catch (e) {
      if (e.message!.contains('PERMISSION_DENIED')) {
        return left(const WorkerFailure.insufficientPermission());
      } else if (e.message!.contains('object-not-found')) {
        return left(const WorkerFailure.unableToUpdate());
      } else {
        return left(const WorkerFailure.unexpected());
      }
    }
  }
}
