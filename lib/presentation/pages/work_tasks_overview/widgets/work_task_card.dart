import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_ddd/application/work_tasks/work_task_actor/work_task_actor_bloc.dart';

import 'package:hello_ddd/domain/work_tasks/work_task.dart';
import 'package:hello_ddd/presentation/routes/router.dart';
import 'package:intl/intl.dart';

class WorkTaskCard extends StatelessWidget {
  final WorkTask workTask;

  const WorkTaskCard({super.key, required this.workTask});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color(0x22000000),
            blurRadius: 4,
            offset: Offset(4, 6),
            spreadRadius: -4,
          )
        ],
      ),
      child: Card(
        elevation: 0.0,
        child: InkWell(
          onTap: () {
            context.router.push(WorkTaskFormRoute(editedWorkTask: workTask));
          },
          onLongPress: () {
            final workTaskActorBloc = context.read<WorkTaskActorBloc>();
            _showDeletionDialog(context, workTaskActorBloc);
          },
          child: Container(
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                side: const BorderSide(width: 1),
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    workTask.name.getOrCrash(),
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    workTask.type.getOrCrash(),
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(fontSize: 12),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    'с ${DateFormat.Hm().format(workTask.beginDate.getOrCrash())} по ${DateFormat.Hm().format(workTask.endDate.getOrCrash())}',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontSize: 10,
                          color: const Color.fromARGB(255, 115, 107, 107),
                        ),
                  ),
                  const SizedBox(height: 15.0),
                  if (workTask.completed)
                    Text(
                      'Задача выполнена.',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                    )
                  else if (workTask.worker == null)
                    Text(
                      'Исполнитель не назначен.',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFFB61717),
                          ),
                    )
                  else
                    Text(
                      'Исполнитель назначен.',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF258039),
                          ),
                    )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showDeletionDialog(
      BuildContext context, WorkTaskActorBloc workTaskActorBloc) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Удалить заявку?',
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          content: Text(
            'Название заявки: "${workTask.name.getOrCrash()}"',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          actions: <Widget>[
            OutlinedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Отмена'),
            ),
            OutlinedButton(
              onPressed: () {
                workTaskActorBloc.add(WorkTaskActorEvent.deleted(workTask));
                Navigator.pop(context);
              },
              child: const Text('Удалить'),
            ),
          ],
        );
      },
    );
  }
}
