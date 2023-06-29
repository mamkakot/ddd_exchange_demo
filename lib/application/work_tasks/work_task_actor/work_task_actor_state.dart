part of 'work_task_actor_bloc.dart';

@freezed
class WorkTaskActorState with _$WorkTaskActorState {
  const factory WorkTaskActorState.initial() = _Initial;
  const factory WorkTaskActorState.actionInProgress() = _ActionInProgress;
  const factory WorkTaskActorState.deleteFailure(WorkTaskFailure noteFailure) =
  _DeleteFailure;
  const factory WorkTaskActorState.deleteSuccess() = _DeleteSuccess;
}
