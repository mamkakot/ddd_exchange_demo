import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

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
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12),
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
                  Text(
                    'Исполнитель не назначен.',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(255, 182, 23, 23),
                        ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
