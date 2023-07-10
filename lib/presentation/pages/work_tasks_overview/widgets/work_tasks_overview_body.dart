import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_ddd/application/work_tasks/work_task_watcher/work_task_watcher_bloc.dart';
import 'package:hello_ddd/domain/work_tasks/work_task.dart';
import 'package:hello_ddd/presentation/pages/work_tasks_overview/widgets/critical_error_display.dart';
import 'package:hello_ddd/presentation/pages/work_tasks_overview/widgets/error_work_task_card.dart';
import 'package:hello_ddd/presentation/pages/work_tasks_overview/widgets/work_task_card.dart';

class WorkTasksOverviewBody extends StatelessWidget {
  const WorkTasksOverviewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorkTaskWatcherBloc, WorkTaskWatcherState>(
        builder: (context, state) {
      return state.map(
        initial: (_) => Container(),
        loadInProgress: (_) => const Center(
          child: CircularProgressIndicator(),
        ),
        loadSuccess: (state) {
          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              final workTask = state.workTasks[index];
              return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28.0),
                  child: (workTask.failureOption.isSome())
                      ? Padding(
                          padding: EdgeInsets.only(
                            bottom: index == state.workTasks.length - 1
                                ? 28.0
                                : 0.0,
                            top: index != 0 ? 20.0 : 28.0,
                          ),
                          child: ErrorWorkTaskCard(workTask: workTask),
                        )
                      : Padding(
                          padding: EdgeInsets.only(
                            bottom: index == state.workTasks.length - 1
                                ? 28.0
                                : 0.0,
                            top: index != 0 ? 20.0 : 28.0,
                          ),
                          child: WorkTaskCard(workTask: workTask),
                        ));
            },
            itemCount: state.workTasks.length,
          );
        },
        loadFailed: (state) =>
            CriticalFailureDisplay(failure: state.workTaskFailure),
      );
    });
  }
}
