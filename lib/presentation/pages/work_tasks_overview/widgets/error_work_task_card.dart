import 'package:flutter/material.dart';
import 'package:hello_ddd/domain/work_tasks/work_task.dart';

class ErrorWorkTaskCard extends StatelessWidget {
  final WorkTask workTask;

  const ErrorWorkTaskCard({super.key, required this.workTask});

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
        color: Theme.of(context).colorScheme.error,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: <Widget>[
              Text(
                'Ошибка при загрузке данных. Пожалуйста, свяжитесь с поддержкой.',
                style: Theme.of(context)
                    .primaryTextTheme
                    .bodyMedium
                    ?.copyWith(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                'Технические детали',
                style: Theme.of(context).primaryTextTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              Text(
                workTask.failureOption.fold(() => '', (f) => f.toString()),
                style: Theme.of(context).primaryTextTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
