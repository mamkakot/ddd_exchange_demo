part of 'work_task_form_bloc.dart';

@freezed
class WorkTaskFormState with _$WorkTaskFormState {
  const factory WorkTaskFormState({
    required WorkTask workTask,
    required bool showErrorMessages,
    required bool isEditing,
    required bool isSaving,
    required Option<Either<WorkTaskFailure, Unit>> saveFailureOrSuccessOption,
  }) = _WorkTaskFormState;

  factory WorkTaskFormState.initial() => WorkTaskFormState(
        workTask: WorkTask.empty(),
        showErrorMessages: false,
        isEditing: false,
        isSaving: false,
        saveFailureOrSuccessOption: none(),
      );
}
