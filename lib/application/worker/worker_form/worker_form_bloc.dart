import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hello_ddd/domain/workers/value_objects.dart';
import 'package:hello_ddd/domain/workers/worker.dart';
import 'package:hello_ddd/domain/workers/worker_failure.dart';

part 'worker_form_event.dart';

part 'worker_form_state.dart';

part 'worker_form_bloc.freezed.dart';

class WorkerFormBloc extends Bloc<WorkerFormEvent, WorkerFormState> {
  WorkerFormBloc() : super(WorkerFormState.initial()) {
    on<WorkerFormEvent>((event, emit) {
      event.map(
        initialized: (e) async {
          await e.initialWorkerOption.fold(
            () async => state,
            (initialWorker) async => emit(
              state.copyWith(
                worker: initialWorker,
                isEditing: true,
              ),
            ),
          );
        },
        fullNameChanged: (e) async {
          emit(
            state.copyWith(
              worker:
                  state.worker.copyWith(fullName: WorkerFullName(e.nameString)),
              saveFailureOrSuccessOption: none(),
            ),
          );
        },
        workerPositionChanged: (e) async {
          emit(
            state.copyWith(
              worker: state.worker
                  .copyWith(position: WorkerPosition(e.positionString)),
              saveFailureOrSuccessOption: none(),
            ),
          );
        },
        saved: (e) async {
          Either<WorkerFailure, Unit>? failureOrSuccess;

          emit(
            state.copyWith(
              isSaving: true,
              saveFailureOrSuccessOption: none(),
            ),
          );

          // if (state.worker.failureOption.isNone()) {
          //   failureOrSuccess = state.isEditing
          //       ? await _workerRepository.update(state.workTask)
          //       : await _workTaskRepository.create(state.workTask);
          // }

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
