import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hello_ddd/application/work_tasks/work_task_form/work_task_form_bloc.dart';
import 'package:hello_ddd/domain/work_tasks/value_objects.dart';

class DescriptionField extends HookWidget {
  const DescriptionField({super.key});

  @override
  Widget build(BuildContext context) {
    final textEditingController = useTextEditingController();

    return BlocListener<WorkTaskFormBloc, WorkTaskFormState>(
      listenWhen: (previous, current) =>
          previous.isEditing != current.isEditing,
      listener: (context, state) {
        textEditingController.text = state.workTask.description.getOrCrash();
      },
      child: TextFormField(
        style: Theme.of(context).textTheme.bodySmall,
        maxLines: 4,
        maxLength: WorkTaskDescription.maxLength,
        controller: textEditingController,
        scrollPhysics: const BouncingScrollPhysics(),
        onChanged: (value) => context
            .read<WorkTaskFormBloc>()
            .add(WorkTaskFormEvent.descriptionChanged(value)),
        validator: (_) => context
            .read<WorkTaskFormBloc>()
            .state
            .workTask
            .description
            .value
            .fold(
                (l) => l.maybeMap(
                    orElse: () => null,
                    valueTooLong: (f) => 'Слишком много символов'),
                (r) => null),
        decoration: InputDecoration(
          enabledBorder: Theme.of(context).inputDecorationTheme.border,
          contentPadding: const EdgeInsets.all(10.0),
        ),
        autocorrect: false,
      ),
    );
  }
}
