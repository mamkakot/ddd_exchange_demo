import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_ddd/application/work_tasks/work_task_form/work_task_form_bloc.dart';
import 'package:hello_ddd/domain/work_tasks/worker.dart';

class WorkerCard extends StatelessWidget {
  const WorkerCard({super.key});

  @override
  Widget build(BuildContext context) {
    Worker? worker;
    return BlocBuilder<WorkTaskFormBloc, WorkTaskFormState>(
        buildWhen: (previous, current) =>
            previous.workTask.worker != current.workTask.worker,
        builder: (context, state) {
          worker = state.workTask.worker;
          return Container(
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                side: const BorderSide(width: 1),
                borderRadius: BorderRadius.circular(5),
              ),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: worker != null
                  ? Row(
                      children: [
                        const SizedBox(
                          height: 80,
                          width: 80,
                          child: Icon(
                            Icons.account_circle,
                            size: 80,
                            color: Color(0xFFD9D9D9),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              worker!.fullName.getOrCrash(),
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            const SizedBox(height: 8.0),
                            Text(
                              worker!.position.getOrCrash(),
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            const SizedBox(height: 8.0),
                            Wrap(
                              children: [
                                Text(
                                  'Рейтинг: ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                          fontSize: 10.0,
                                          fontWeight: FontWeight.normal,
                                          color: const Color(0xFF777777)),
                                ),
                                Text(
                                  "${worker!.rating.getOrCrash()}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                          fontSize: 10.0,
                                          fontWeight: FontWeight.bold,
                                          color: getColorFromRating(
                                              worker!.rating.getOrCrash())),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    )
                  : Row(
                      children: [
                        const SizedBox(
                          height: 80,
                          width: 80,
                          child: Icon(
                            Icons.no_accounts_rounded,
                            size: 80,
                            color: Color(0xFFD9D9D9),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'Не назначен.',
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ],
                    ),
            ),
          );
        });
  }

  Color getColorFromRating(double rating) {
    if (rating >= 4.5) {
      return const Color(0xFF258039);
    }

    if (rating >= 2.5) {
      return const Color(0xFFD4A704);
    }

    return const Color(0xFFB61717);
  }
}
