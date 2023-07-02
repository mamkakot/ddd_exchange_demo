import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hello_ddd/domain/work_tasks/work_task.dart';
import 'package:hello_ddd/domain/work_tasks/work_task_failure.dart';

import '../../../domain/work_tasks/store.dart';

part 'work_task_form_event.dart';
part 'work_task_form_state.dart';
part 'work_task_form_bloc.freezed.dart';

class WorkTaskFormBloc extends Bloc<WorkTaskFormEvent, WorkTaskFormState> {
  WorkTaskFormBloc() : super(WorkTaskFormState.initial()) {
    on<WorkTaskFormEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
