import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:hello_ddd/domain/work_tasks/i_work_task_repository.dart';
import 'package:hello_ddd/domain/work_tasks/work_task.dart';
import 'package:hello_ddd/domain/work_tasks/work_task_failure.dart';
import 'package:hello_ddd/infrastructure/core/firestore_helpers.dart';
import 'package:hello_ddd/infrastructure/work_tasks/work_task_dtos.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@LazySingleton(as: IWorkTaskRepository)
class WorkTaskRepository implements IWorkTaskRepository {
  final FirebaseFirestore _firestore;

  WorkTaskRepository(this._firestore);

  @override
  Stream<Either<WorkTaskFailure, List<WorkTask>>> watchAll() async* {
    final userDoc = await _firestore.userDocument();
    print(userDoc.workTaskCollection);

    yield* userDoc.workTaskCollection
        . orderBy('serverTimeStamp', descending: true)
        .snapshots()
        .map(
          (snapshot) => right<WorkTaskFailure, List<WorkTask>>(
            snapshot.docs
                .map((doc) => WorkTaskDTO.fromFirestore(doc).toDomain())
                .toList(),
          ),
        )
        .onErrorReturnWith((e, st) {
      if (e is FirebaseException && e.message!.contains('PERMISSION_DENIED')) {
        print(e.toString());
        return left(const WorkTaskFailure.insufficientPermission());
      } else {
        print(e.toString());
        return left(const WorkTaskFailure.unexpected());
      }
    });
  }

  @override
  Stream<Either<WorkTaskFailure, List<WorkTask>>> watchUncompleted() async* {
    final userDoc = await _firestore.userDocument();
    yield* userDoc.workTaskCollection
        .orderBy('serverTimeStamp', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => WorkTaskDTO.fromFirestore(doc).toDomain()),
        )
        .map(
          (workTasks) => right<WorkTaskFailure, List<WorkTask>>(
            workTasks.where((workTask) => !workTask.completed).toList(),
          ),
        )
        .onErrorReturnWith((e, st) {
      if (e is FirebaseException && e.message!.contains('PERMISSION_DENIED')) {
        return left(const WorkTaskFailure.insufficientPermission());
      } else {
        return left(const WorkTaskFailure.unexpected());
      }
    });
  }

  @override
  Future<Either<WorkTaskFailure, Unit>> create(WorkTask workTask) async {
    try {
      final userDoc = await _firestore.userDocument();
      final workTaskDTO = WorkTaskDTO.fromDomain(workTask);

      await userDoc.workTaskCollection
          .doc(workTaskDTO.id)
          .set(workTaskDTO.toJson());

      return right(unit);
    } on FirebaseException catch (e) {
      if (e.message!.contains('PERMISSION_DENIED')) {
        return left(const WorkTaskFailure.insufficientPermission());
      } else {
        return left(const WorkTaskFailure.unexpected());
      }
    }
  }

  @override
  Future<Either<WorkTaskFailure, Unit>> delete(WorkTask workTask) async {
    try {
      final userDoc = await _firestore.userDocument();
      final workTaskId = workTask.id.getOrCrash();

      await userDoc.workTaskCollection.doc(workTaskId).delete();

      return right(unit);
    } on FirebaseException catch (e) {
      if (e.message!.contains('PERMISSION_DENIED')) {
        return left(const WorkTaskFailure.insufficientPermission());
      } else if (e.message!.contains('object-not-found')) {
        return left(const WorkTaskFailure.unableToUpdate());
      } else {
        return left(const WorkTaskFailure.unexpected());
      }
    }
  }

  @override
  Future<Either<WorkTaskFailure, Unit>> update(WorkTask workTask) async {
    try {
      final userDoc = await _firestore.userDocument();
      final workTaskDTO = WorkTaskDTO.fromDomain(workTask);

      await userDoc.workTaskCollection
          .doc(workTaskDTO.id)
          .update(workTaskDTO.toJson());

      return right(unit);
    } on FirebaseException catch (e) {
      if (e.message!.contains('PERMISSION_DENIED')) {
        return left(const WorkTaskFailure.insufficientPermission());
      } else if (e.message!.contains('object-not-found')) {
        return left(const WorkTaskFailure.unableToUpdate());
      } else {
        return left(const WorkTaskFailure.unexpected());
      }
    }
  }
}
