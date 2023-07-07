import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_ddd/application/work_tasks/work_task_form/work_task_form_bloc.dart';
import 'package:hello_ddd/domain/work_tasks/value_objects.dart';

class TypeField extends StatelessWidget {
  const TypeField({super.key});

  @override
  Widget build(BuildContext context) {
    String dropdownValue = WorkTaskType.predefinedTypes.first;

    return BlocListener<WorkTaskFormBloc, WorkTaskFormState>(
      listenWhen: (previous, current) =>
          previous.workTask.type != current.workTask.type,
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
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ))
              .toList(),
          onChanged: (String? value) => context
              .read<WorkTaskFormBloc>()
              .add(WorkTaskFormEvent.typeChanged(value!)),
          // decoration: InputDecoration(),
        ),
      ),
    );
  }
}
