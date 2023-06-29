part of 'work_task_actor_bloc.dart';

@freezed
class WorkTaskActorEvent with _$WorkTaskActorEvent {
  const factory WorkTaskActorEvent.deleted(WorkTask workTask) = _Deleted;
}
