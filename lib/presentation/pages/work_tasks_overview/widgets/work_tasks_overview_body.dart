import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_ddd/application/work_tasks/work_task_watcher/work_task_watcher_bloc.dart';
import 'package:hello_ddd/domain/work_tasks/work_task.dart';
import 'package:hello_ddd/presentation/pages/work_tasks_overview/widgets/critical_error_display.dart';
import 'package:hello_ddd/presentation/pages/work_tasks_overview/widgets/error_work_task_card.dart';
import 'package:hello_ddd/presentation/pages/work_tasks_overview/widgets/work_task_card.dart';
import 'package:intl/intl.dart';

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
          var workTaskDates = state.workTasks
              .map((e) => e.beginDate.getOrCrash().copyWith(
                    hour: 0,
                    minute: 0,
                    millisecond: 0,
                    microsecond: 0,
                    second: 0,
                  ))
              .toSet()
              .toList();
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: workTaskDates.length,
              itemBuilder: (context, datesIndex) {
                final date = workTaskDates[datesIndex];

                final workTasks = state.workTasks
                    .where((element) =>
                        element.beginDate
                            .getOrCrash()
                            .difference(date)
                            .inDays ==
                        0)
                    .toList();
                return ExpandablePanel(
                  theme: const ExpandableThemeData(
                    iconColor: Color(0xFF00A199),
                    headerAlignment: ExpandablePanelHeaderAlignment.center,
                    iconPadding: EdgeInsets.only(
                      right: 28.0,
                      bottom: 5.0,
                      top: 5.0,
                    ),
                  ),
                  header: Padding(
                    padding: const EdgeInsets.only(left: 28.0),
                    child: Text(DateFormat.yMMMMd('ru').format(date),
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: const Color(0xFF00A199))),
                  ),
                  collapsed: const SizedBox(height: 0),
                  expanded: ListView.builder(
                    physics: const ClampingScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final workTask = workTasks[index];
                      return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 28.0),
                          child: (workTask.failureOption.isSome())
                              ? Padding(
                                  padding: EdgeInsets.only(
                                    bottom: index == workTasks.length - 1
                                        ? 10.0
                                        : 0.0,
                                    top: index != 0 ? 20.0 : 10.0,
                                  ),
                                  child: ErrorWorkTaskCard(workTask: workTask),
                                )
                              : Padding(
                                  padding: EdgeInsets.only(
                                    bottom: index == workTasks.length - 1
                                        ? 10.0
                                        : 0.0,
                                    top: index != 0 ? 20.0 : 10.0,
                                  ),
                                  child: WorkTaskCard(workTask: workTask),
                                ));
                    },
                    itemCount: workTasks.length,
                  ),
                );
              },
            ),
          );
        },
        loadFailed: (state) =>
            CriticalFailureDisplay(failure: state.workTaskFailure),
      );
    });
  }
}
