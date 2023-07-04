part of 'work_task_form_bloc.dart';

@freezed
class WorkTaskFormEvent with _$WorkTaskFormEvent {
  const factory WorkTaskFormEvent.initialized(
      Option<WorkTask> initialWorkTaskOption) = _Initialized;

  const factory WorkTaskFormEvent.nameChanged(String nameStr) = _NameChanged;

  const factory WorkTaskFormEvent.typeChanged(String type) = _TypeChanged;

  const factory WorkTaskFormEvent.hoursChanged(double hours) = _HoursChanged;

  const factory WorkTaskFormEvent.beginHourChanged(DateTime beginHour) =
      _BeginHourChanged;
  const factory WorkTaskFormEvent.endHourChanged(DateTime endHour) =
      _EndHourChanged;

  const factory WorkTaskFormEvent.storeChanged(Store store) = _StoreChanged;

  const factory WorkTaskFormEvent.saved() = _Saved;
}
