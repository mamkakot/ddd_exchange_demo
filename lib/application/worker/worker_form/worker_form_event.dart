part of 'worker_form_bloc.dart';

@freezed
class WorkerFormEvent with _$WorkerFormEvent {
  const factory WorkerFormEvent.initialized(
      Option<Worker> initialWorkerOption) = _Initialized;

  const factory WorkerFormEvent.fullNameChanged(String nameString) =
      _FullNameChanged;

  const factory WorkerFormEvent.workerPositionChanged(String positionString) =
      _WorkerPositionChanged;

  const factory WorkerFormEvent.saved() = _Saved;
}
