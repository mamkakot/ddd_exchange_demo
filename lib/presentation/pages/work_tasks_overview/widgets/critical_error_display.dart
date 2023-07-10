import 'package:flutter/material.dart';
import 'package:hello_ddd/domain/work_tasks/work_task_failure.dart';

class CriticalFailureDisplay extends StatelessWidget {
  final WorkTaskFailure failure;

  const CriticalFailureDisplay({super.key, required this.failure});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const Text(
            '😱',
            style: TextStyle(fontSize: 100),
          ),
          Text(
            failure.maybeMap(
              insufficientPermission: (_) => 'Недостаточно прав',
              orElse: () =>
                  'Неожиданная ошибка, пожалуйста, свяжитесь с поддержкой.',
            ),
            style: const TextStyle(fontSize: 24),
            textAlign: TextAlign.center,
          ),
          OutlinedButton(
            onPressed: () {
              // TODO: добавить отправку сообщения об ошибке
              print('Sending email!');
            },
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(Icons.mail),
                SizedBox(width: 4),
                Text('Мне нужна помощь.'),
              ],
            ),
          )
        ],
      ),
    );
  }
}
