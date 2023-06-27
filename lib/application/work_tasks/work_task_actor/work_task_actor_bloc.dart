import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'work_task_actor_event.dart';

part 'work_task_actor_state.dart';

class WorkTaskActorBloc extends Bloc<WorkTaskActorEvent, WorkTaskActorState> {
  WorkTaskActorBloc() : super(WorkTaskActorInitial()) {
    on<WorkTaskActorEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
