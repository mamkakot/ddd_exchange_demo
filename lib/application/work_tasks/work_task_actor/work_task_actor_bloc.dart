import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hello_ddd/domain/work_tasks/i_work_task_repository.dart';
import 'package:hello_ddd/domain/work_tasks/work_task.dart';
import 'package:hello_ddd/domain/work_tasks/work_task_failure.dart';
import 'package:injectable/injectable.dart';

part 'work_task_actor_event.dart';

part 'work_task_actor_state.dart';

part 'work_task_actor_bloc.freezed.dart';

@injectable
class WorkTaskActorBloc extends Bloc<WorkTaskActorEvent, WorkTaskActorState> {
  final IWorkTaskRepository _workTaskRepository;

  WorkTaskActorBloc(this._workTaskRepository)
      : super(const WorkTaskActorState.initial()) {
    on<WorkTaskActorEvent>((event, emit) async {
      await event.map(deleted: (e) async {
        emit(const WorkTaskActorState.actionInProgress());
        final possibleFailure =
            await _workTaskRepository.delete(event.workTask);
        possibleFailure.fold(
          (f) => emit(WorkTaskActorState.deleteFailure(f)),
          (r) => emit(const WorkTaskActorState.deleteSuccess()),
        );
      });
    });
  }
}
