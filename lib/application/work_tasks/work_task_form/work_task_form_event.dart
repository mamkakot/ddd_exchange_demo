part of 'work_task_form_bloc.dart';

@freezed
class WorkTaskFormEvent with _$WorkTaskFormEvent {
  const factory WorkTaskFormEvent.initialized(
      Option<WorkTask> initialWorkTaskOption) = _Initialized;

  const factory WorkTaskFormEvent.nameChanged(String nameStr) = _NameChanged;

  const factory WorkTaskFormEvent.descriptionChanged(String descriptionStr) =
      _DescriptionChanged;

  const factory WorkTaskFormEvent.typeChanged(String type) = _TypeChanged;

  const factory WorkTaskFormEvent.hoursChanged(double hours) = _HoursChanged;

  const factory WorkTaskFormEvent.beginDateChanged(DateTime beginDate) =
      _BeginDateChanged;

  const factory WorkTaskFormEvent.endDateChanged(DateTime endDate) =
      _EndDateChanged;

  const factory WorkTaskFormEvent.storeChanged(Store store) = _StoreChanged;

  const factory WorkTaskFormEvent.saved() = _Saved;
}
