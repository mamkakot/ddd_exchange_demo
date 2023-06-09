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
          return state.workTasks.isEmpty
              ? const Center(
                  child: Text(
                    'Здесь пока ничего нет.\nНажмите на "+", чтобы добавить заявку.',
                    textAlign: TextAlign.center,
                  ),
                )
              : Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Text(
                          "* здесь будет расположена полоска с чипами, по которым можно будет делать отборы *"),
                    ),
                    // TODO: добавить chip'ы
                    Expanded(
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: state.workTaskDates.length,
                        itemBuilder: (context, datesIndex) {
                          final date = state.workTaskDates[datesIndex];

                          final workTasks = state.workTasks
                              .where((element) =>
                                  element.beginDate
                                      .getOrCrash()
                                      .difference(date)
                                      .inDays ==
                                  0)
                              .toList();
                          return ExpansionTile(
                            // theme: const ExpandableThemeData(
                            //   iconColor: Color(0xFF00A199),
                            //   headerAlignment:
                            //       ExpandablePanelHeaderAlignment.center,
                            //   iconPadding: EdgeInsets.only(
                            //     right: 28.0,
                            //     bottom: 5.0,
                            //     top: 5.0,
                            //   ),
                            // ),

                            maintainState: true,
                            title: Padding(
                              padding: const EdgeInsets.only(left: 28.0),
                              child: Text(DateFormat.yMMMMd('ru').format(date),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                          color: const Color(0xFF00A199))),
                            ),
                            children: [
                              ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  final workTask = workTasks[index];
                                  return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 28.0),
                                      child: (workTask.failureOption.isSome())
                                          ? Padding(
                                              padding: EdgeInsets.only(
                                                bottom: index ==
                                                        workTasks.length - 1
                                                    ? 10.0
                                                    : 0.0,
                                                top: index != 0 ? 20.0 : 10.0,
                                              ),
                                              child: ErrorWorkTaskCard(
                                                  workTask: workTask),
                                            )
                                          : Padding(
                                              padding: EdgeInsets.only(
                                                bottom: index ==
                                                        workTasks.length - 1
                                                    ? 10.0
                                                    : 0.0,
                                                top: index != 0 ? 20.0 : 10.0,
                                              ),
                                              child: WorkTaskCard(
                                                  workTask: workTask),
                                            ));
                                },
                                itemCount: workTasks.length,
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                );
        },
        loadFailed: (state) =>
            CriticalFailureDisplay(failure: state.workTaskFailure),
      );
    });
  }
}
