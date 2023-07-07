import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hello_ddd/domain/work_tasks/work_task_failure.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/work_tasks/i_work_task_repository.dart';
import '../../../domain/work_tasks/work_task.dart';

part 'work_task_watcher_event.dart';

part 'work_task_watcher_state.dart';

part 'work_task_watcher_bloc.freezed.dart';

@injectable
class WorkTaskWatcherBloc
    extends Bloc<WorkTaskWatcherEvent, WorkTaskWatcherState> {
  final IWorkTaskRepository _workTaskRepository;

  StreamSubscription<Either<WorkTaskFailure, List<WorkTask>>>?
      _workTaskStreamSubscription;

  WorkTaskWatcherBloc(this._workTaskRepository)
      : super(const WorkTaskWatcherState.initial()) {
    on<WorkTaskWatcherEvent>((event, emit) async {
      await event.map(
        watchAllStarted: (e) async {
          emit(const WorkTaskWatcherState.loadInProgress());
          await _workTaskStreamSubscription?.cancel();
          _workTaskStreamSubscription =
              _workTaskRepository.watchAll().listen((failureOrWorkTasks) {
            add(WorkTaskWatcherEvent.workTasksReceived(failureOrWorkTasks));
          });
        },
        watchUncompletedStarted: (e) async {
          emit(const WorkTaskWatcherState.loadInProgress());
          await _workTaskStreamSubscription?.cancel();
          _workTaskStreamSubscription = _workTaskRepository
              .watchUncompleted()
              .listen((failureOrWorkTasks) {
            add(WorkTaskWatcherEvent.workTasksReceived(failureOrWorkTasks));
          });
        },
        workTasksReceived: (e) async {
          await e.failureOrWorkTasks.fold(
            (failure) async => emit(WorkTaskWatcherState.loadFailed(failure)),
            (workTasks) async =>
                emit(WorkTaskWatcherState.loadSuccess(workTasks)),
          );
        },
      );
    });
  }

  @override
  Future<void> close() async {
    await _workTaskStreamSubscription?.cancel();
    return super.close();
  }
}
