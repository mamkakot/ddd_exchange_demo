part of 'work_task_watcher_bloc.dart';

@freezed
class WorkTaskWatcherState with _$WorkTaskWatcherState {
  const factory WorkTaskWatcherState.initial() = _Initial;

  const factory WorkTaskWatcherState.loadInProgress() = _LoadInProgress;

  const factory WorkTaskWatcherState.loadSuccess(List<WorkTask> workTasks, List<DateTime> workTaskDates) =
      _LoadSuccess;

  const factory WorkTaskWatcherState.loadFailed(
      WorkTaskFailure workTaskFailure) = _LoadFailed;
}
