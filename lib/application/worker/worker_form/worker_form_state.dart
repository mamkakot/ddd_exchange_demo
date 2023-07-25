part of 'worker_form_bloc.dart';

@freezed
class WorkerFormState with _$WorkerFormState {
  const factory WorkerFormState({
    required Worker worker,
    required bool showErrorMessages,
    required bool isEditing,
    required bool isSaving,
    required Option<Either<WorkerFailure, Unit>> saveFailureOrSuccessOption,
  }) = _WorkTaskFormState;

  factory WorkerFormState.initial() => WorkerFormState(
        worker: Worker.empty(),
        showErrorMessages: false,
        isEditing: false,
        isSaving: false,
        saveFailureOrSuccessOption: none(),
      );
}
