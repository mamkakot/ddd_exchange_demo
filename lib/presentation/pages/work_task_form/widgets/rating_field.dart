import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hello_ddd/application/work_tasks/work_task_form/work_task_form_bloc.dart';

class RatingField extends HookWidget {
  const RatingField({super.key});

  @override
  Widget build(BuildContext context) {
    int selectedRating =
        context.read<WorkTaskFormBloc>().state.workTask.rating != null
            ? context
                .read<WorkTaskFormBloc>()
                .state
                .workTask
                .rating!
                .getOrCrash()
            : 0;

    return BlocBuilder<WorkTaskFormBloc, WorkTaskFormState>(
      buildWhen: (previous, current) =>
          previous.workTask.rating != current.workTask.rating,
      builder: (context, state) {
        selectedRating = state.workTask.rating != null
            ? state.workTask.rating!.getOrCrash()
            : 0;
        return RatingBar.builder(
          initialRating: selectedRating.toDouble(),
          minRating: 0.0,
          maxRating: 5.0,
          direction: Axis.horizontal,
          allowHalfRating: false,
          itemCount: 5,
          itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
          itemSize: 25.0,
          itemBuilder: (context, _) => const Icon(
            Icons.star,
            color: Colors.amber,
          ),
          onRatingUpdate: (rating) {
            context
                .read<WorkTaskFormBloc>()
                .add(WorkTaskFormEvent.ratingChanged(rating.toInt()));
          },
        );
      },
    );
  }
}
