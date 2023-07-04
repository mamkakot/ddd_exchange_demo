import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hello_ddd/application/work_tasks/work_task_form/work_task_form_bloc.dart';
import 'package:hello_ddd/domain/work_tasks/value_objects.dart';

class TypeField extends HookWidget {
  const TypeField({super.key});

  @override
  Widget build(BuildContext context) {
    String dropdownValue = WorkTaskType.predefinedTypes.first;

    return BlocListener<WorkTaskFormBloc, WorkTaskFormState>(
      listenWhen: (previous, current) =>
          previous.isEditing != current.isEditing,
      listener: (context, state) {
        dropdownValue = state.workTask.type.getOrCrash();
      },
      child: SizedBox(
        height: 35,
        child: DropdownButtonFormField<String>(
          isExpanded: true,
          value: dropdownValue,
          icon: const Icon(Icons.keyboard_arrow_down_outlined),
          items: WorkTaskType.predefinedTypes
              .map<DropdownMenuItem<String>>((String value) => DropdownMenuItem(
                    value: value,
                    child: Text(
                      value,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ))
              .toList(),
          onChanged: (String? value) => context
              .read<WorkTaskFormBloc>()
              .add(WorkTaskFormEvent.typeChanged(value!)),
          // decoration: InputDecoration(),
        ),
      ),
      // child: SizedBox(
      //   height:
      //   context.read<WorkTaskFormBloc>().state.workTask.name.isValid() ||
      //       !context.read<WorkTaskFormBloc>().state.showErrorMessages
      //       ? 35
      //       : 57,
      //   child: TextFormField(
      //     controller: textEditingController,
      //     maxLength: WorkTaskName.maxLength,
      //     onChanged: (value) => context
      //         .read<WorkTaskFormBloc>()
      //         .add(WorkTaskFormEvent.nameChanged(value)),
      //     validator: (_) => context
      //         .read<WorkTaskFormBloc>()
      //         .state
      //         .workTask
      //         .name
      //         .value
      //         .fold(
      //             (l) => l.maybeMap(
      //             orElse: () => null,
      //             empty: (f) => 'Cannot be empty',
      //             valueTooLong: (f) => 'Value too long'),
      //             (r) => null),
      //     maxLines: 1,
      //     decoration: InputDecoration(
      //       enabledBorder: Theme.of(context).inputDecorationTheme.border,
      //     ),
      //     autocorrect: false,
      //   ),
      // ),
    );
  }
}
