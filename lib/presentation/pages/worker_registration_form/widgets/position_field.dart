import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../../../../application/worker/worker_form/worker_form_bloc.dart';
import '../../../../domain/workers/value_objects.dart';

class PositionField extends HookWidget {
  const PositionField({super.key});

  @override
  Widget build(BuildContext context) {
    final textEditingController = useTextEditingController();

    return BlocListener<WorkerFormBloc, WorkerFormState>(
      listenWhen: (previous, current) =>
          previous.isEditing != current.isEditing,
      listener: (context, state) {
        textEditingController.text = state.worker.position.getOrCrash();
      },
      child: SizedBox(
        height: 57,
        child: TextFormField(
          style: Theme.of(context).textTheme.bodySmall,
          controller: textEditingController,
          maxLength: WorkerPosition.maxLength,
          onChanged: (value) => context
              .read<WorkerFormBloc>()
              .add(WorkerFormEvent.workerPositionChanged(value)),
          validator: (_) => context
              .read<WorkerFormBloc>()
              .state
              .worker
              .position
              .value
              .fold(
                  (l) => l.maybeMap(
                      orElse: () => null,
                      empty: (f) => 'Не может быть пустым',
                      valueTooLong: (f) => 'Слишком много символов'),
                  (r) => null),
          maxLines: 1,
          decoration: InputDecoration(
            enabledBorder: Theme.of(context).inputDecorationTheme.border,
          ),
          autocorrect: false,
        ),
      ),
    );
  }
}
