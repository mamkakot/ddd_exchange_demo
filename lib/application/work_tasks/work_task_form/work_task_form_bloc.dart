import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hello_ddd/domain/work_tasks/i_work_task_repository.dart';
import 'package:hello_ddd/domain/work_tasks/value_objects.dart';
import 'package:hello_ddd/domain/work_tasks/work_task.dart';
import 'package:hello_ddd/domain/work_tasks/work_task_failure.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/work_tasks/store.dart';

part 'work_task_form_event.dart';

part 'work_task_form_state.dart';

part 'work_task_form_bloc.freezed.dart';

@injectable
class WorkTaskFormBloc extends Bloc<WorkTaskFormEvent, WorkTaskFormState> {
  final IWorkTaskRepository _workTaskRepository;

  WorkTaskFormBloc(this._workTaskRepository)
      : super(WorkTaskFormState.initial()) {
    on<WorkTaskFormEvent>((event, emit) async {
      await event.map(
        initialized: (e) async {
          await e.initialWorkTaskOption.fold(
            () async => state,
            (initialWorkTask) async => emit(
              state.copyWith(
                workTask: initialWorkTask,
                isEditing: true,
              ),
            ),
          );
        },
        nameChanged: (e) async {
          emit(
            state.copyWith(
              workTask: state.workTask.copyWith(name: WorkTaskName(e.nameStr)),
              saveFailureOrSuccessOption: none(),
            ),
          );
        },
        typeChanged: (e) async {
          emit(
            state.copyWith(
              workTask: state.workTask.copyWith(type: WorkTaskType(e.type)),
              saveFailureOrSuccessOption: none(),
            ),
          );
        },
        hoursChanged: (e) async {
          emit(
            state.copyWith(
              workTask: state.workTask.copyWith(hours: WorkTaskHours(e.hours)),
              saveFailureOrSuccessOption: none(),
            ),
          );
        },
        beginHourChanged: (e) async {
          emit(
            state.copyWith(
              workTask: state.workTask
                  .copyWith(beginHour: WorkTaskBegin(e.beginHour)),
              saveFailureOrSuccessOption: none(),
            ),
          );
        },
        endHourChanged: (e) async {
          emit(
            state.copyWith(
              workTask:
                  state.workTask.copyWith(endHour: WorkTaskEnd(e.endHour)),
              saveFailureOrSuccessOption: none(),
            ),
          );
        },
        storeChanged: (e) async {
          emit(
            state.copyWith(
              workTask: state.workTask.copyWith(store: e.store),
              saveFailureOrSuccessOption: none(),
            ),
          );
        },
        saved: (e) async {
          Either<WorkTaskFailure, Unit>? failureOrSuccess;

          emit(
            state.copyWith(
              isSaving: true,
              saveFailureOrSuccessOption: none(),
            ),
          );

          if (state.workTask.failureOption.isNone()) {
            failureOrSuccess = state.isEditing
                ? await _workTaskRepository.update(state.workTask)
                : await _workTaskRepository.create(state.workTask);
          }

          emit(
            state.copyWith(
              isSaving: false,
              showErrorMessages: true,
              saveFailureOrSuccessOption: optionOf(failureOrSuccess),
            ),
          );
        },
      );
    });
  }
}
