part of 'work_task_watcher_bloc.dart';

@freezed
class WorkTaskWatcherEvent with _$WorkTaskWatcherEvent {
  const factory WorkTaskWatcherEvent.watchAllStarted() = _WatchAllStarted;

  const factory WorkTaskWatcherEvent.watchUncompletedStarted() =
      _WatchUncompletedStarted;

  const factory WorkTaskWatcherEvent.workTasksReceived(
          Either<WorkTaskFailure, List<WorkTask>> failureOrWorkTasks) =
      _WorkTasksReceived;
}
