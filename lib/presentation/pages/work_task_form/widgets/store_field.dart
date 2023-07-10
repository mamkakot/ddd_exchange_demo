import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_ddd/application/work_tasks/work_task_form/work_task_form_bloc.dart';
import 'package:hello_ddd/domain/work_tasks/store.dart';

class StoreField extends StatelessWidget {
  const StoreField({super.key});

  @override
  Widget build(BuildContext context) {
    String dropdownValue =
        context.read<WorkTaskFormBloc>().state.workTask.store.name.getOrCrash();

    return BlocConsumer<WorkTaskFormBloc, WorkTaskFormState>(
      buildWhen: (previous, current) =>
          previous.workTask.store.name != current.workTask.store.name,
      listener: (context, state) {
        dropdownValue = state.workTask.store.name.getOrCrash();
      },
      builder: (contex, state) => SizedBox(
        height: 35,
        child: DropdownButtonFormField<String>(
          isExpanded: true,
          value: dropdownValue,
          icon: const Icon(Icons.keyboard_arrow_down_outlined),
          items: Store.predefinedStores
              .map<DropdownMenuItem<String>>((Store value) => DropdownMenuItem(
                    value: value.name.getOrCrash(),
                    child: Text(
                      value.name.getOrCrash(),
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ))
              .toList(),
          onChanged: (String? value) => context.read<WorkTaskFormBloc>().add(
              WorkTaskFormEvent.storeChanged(Store.predefinedStores.singleWhere(
                  (element) => element.name.getOrCrash() == value))),
          // decoration: InputDecoration(),
        ),
      ),
    );
  }
}
