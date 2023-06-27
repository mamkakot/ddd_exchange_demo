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

  WorkTaskWatcherBloc(this._workTaskRepository)
      : super(const WorkTaskWatcherState.initial()) {
    on<WorkTaskWatcherEvent>((event, emit) {
      event.map(
        watchAllStarted: (e) async* {
          // TODO: переделать yield-ы
          yield const WorkTaskWatcherState.loadInProgress();
          _workTaskRepository.watchAll().listen((failureOrWorkTasks) {
            add(WorkTaskWatcherEvent.workTasksReceived(failureOrWorkTasks));
          });
        },
        watchUncompletedStarted: (e) async {},
        workTasksReceived: (e) async* {
          yield e.failureOrWorkTasks.fold(
            (failure) => WorkTaskWatcherState.loadFailed(failure),
            (workTasks) => WorkTaskWatcherState.loadSuccess(workTasks),
          );
        },
      );
    });
  }
}
