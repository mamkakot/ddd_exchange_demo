import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_ddd/application/work_tasks/work_task_form/work_task_form_bloc.dart';
import 'package:hello_ddd/domain/work_tasks/store.dart';

class StoreField extends StatelessWidget {
  const StoreField({super.key});

  @override
  Widget build(BuildContext context) {
    Store dropdownValue = Store.predefinedStores.first;

    return BlocListener<WorkTaskFormBloc, WorkTaskFormState>(
      listenWhen: (previous, current) =>
          previous.workTask.type != current.workTask.type,
      listener: (context, state) {
        dropdownValue = state.workTask.store;
      },
      child: SizedBox(
        height: 35,
        child: DropdownButtonFormField<Store>(
          isExpanded: true,
          value: dropdownValue,
          icon: const Icon(Icons.keyboard_arrow_down_outlined),
          items: Store.predefinedStores
              .map<DropdownMenuItem<Store>>((Store value) => DropdownMenuItem(
                    value: value,
                    child: Text(
                      value.name.getOrCrash(),
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ))
              .toList(),
          onChanged: (Store? value) => context
              .read<WorkTaskFormBloc>()
              .add(WorkTaskFormEvent.storeChanged(value!)),
          // decoration: InputDecoration(),
        ),
      ),
    );
  }
}
