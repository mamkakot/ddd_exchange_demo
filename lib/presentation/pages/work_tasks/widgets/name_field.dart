import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hello_ddd/application/work_tasks/work_task_form/work_task_form_bloc.dart';
import 'package:hello_ddd/domain/work_tasks/value_objects.dart';

class NameField extends HookWidget {
  const NameField({super.key});

  @override
  Widget build(BuildContext context) {
    final textEditingController = useTextEditingController();

    return BlocListener<WorkTaskFormBloc, WorkTaskFormState>(
      listenWhen: (previous, current) =>
          previous.isEditing != current.isEditing,
      listener: (context, state) {
        textEditingController.text = state.workTask.name.getOrCrash();
      },
      child: SizedBox(
        height: 57,
        child: TextFormField(
          controller: textEditingController,
          maxLength: WorkTaskName.maxLength,
          onChanged: (value) => context
              .read<WorkTaskFormBloc>()
              .add(WorkTaskFormEvent.nameChanged(value)),
          validator: (_) => context
              .read<WorkTaskFormBloc>()
              .state
              .workTask
              .name
              .value
              .fold(
                  (l) => l.maybeMap(
                      orElse: () => null,
                      empty: (f) => 'Cannot be empty',
                      valueTooLong: (f) => 'Value too long'),
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
