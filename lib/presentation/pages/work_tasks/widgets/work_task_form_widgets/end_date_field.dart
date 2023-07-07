import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker_bdaya/flutter_datetime_picker_bdaya.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hello_ddd/application/work_tasks/work_task_form/work_task_form_bloc.dart';
import 'package:intl/intl.dart';

class EndDateField extends HookWidget {
  const EndDateField({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime selectedValue = DateTime.now().add(const Duration(hours: 8));

    return BlocBuilder<WorkTaskFormBloc, WorkTaskFormState>(
      buildWhen: (previous, current) =>
          previous.workTask.endDate != current.workTask.endDate,
      builder: (context, state) {
        selectedValue = state.workTask.endDate.getOrCrash();
        return Container(
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              side: const BorderSide(width: 1),
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          height: 35,
          child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 3.0),
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 1),
                  borderRadius: BorderRadius.circular(5),
                ),
                backgroundColor: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      DateFormat.yMMMMd('ru')
                          .add_Hm()
                          .format(selectedValue.toLocal())
                          .toString(),
                      style: Theme.of(context).textTheme.bodySmall),
                  const Icon(Icons.calendar_month_outlined),
                ],
              ),
              onPressed: () {
                DatePickerBdaya.showDateTimePicker(
                  context,
                  showTitleActions: true,
                  minTime: DateTime(2023, 01, 01),
                  maxTime: DateTime(2023, 12, 31),
                  onChanged: (date) {
                    print('change $date');
                  },
                  onConfirm: (date) => context
                      .read<WorkTaskFormBloc>()
                      .add(WorkTaskFormEvent.endDateChanged(date)),
                  locale: LocaleType.ru,
                );
              }),
        );
      },
    );
  }
}
