import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_ddd/application/work_tasks/work_task_watcher/work_task_watcher_bloc.dart';
import 'package:hello_ddd/domain/work_tasks/work_task.dart';
import 'package:hello_ddd/presentation/pages/work_tasks/widgets/work_tasks_overview_widgets/work_task_card.dart';

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
            return Padding(
              padding: const EdgeInsets.all(28.0),
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  final workTask = state.workTasks[index];
                  if (workTask.failureOption.isSome()) {
                    return Container(
                      color: Colors.red,
                      width: 100,
                      height: 100,
                    );
                  } else {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: WorkTaskCard(workTask: workTask),
                    );
                  }
                },
                itemCount: state.workTasks.length,
              ),
            );
          },
          loadFailed: (state) => Container(
                color: Colors.amberAccent,
                width: 200,
                height: 200,
              ));
    });
  }
}
