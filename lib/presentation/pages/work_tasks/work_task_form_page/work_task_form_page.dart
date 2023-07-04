import 'package:another_flushbar/flushbar_helper.dart';
import 'package:auto_route/auto_route.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_ddd/application/work_tasks/work_task_form/work_task_form_bloc.dart';
import 'package:hello_ddd/domain/work_tasks/work_task.dart';
import 'package:hello_ddd/injection.dart';
import 'package:hello_ddd/presentation/pages/work_tasks/widgets/name_field.dart';
import 'package:hello_ddd/presentation/pages/work_tasks/widgets/type_field.dart';

import '../../../routes/router.dart';

@RoutePage()
class WorkTaskFormPage extends StatelessWidget {
  final WorkTask? editedWorkTask;

  const WorkTaskFormPage({super.key, required this.editedWorkTask});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<WorkTaskFormBloc>()
        ..add(WorkTaskFormEvent.initialized(optionOf(editedWorkTask))),
      child: BlocConsumer<WorkTaskFormBloc, WorkTaskFormState>(
        listenWhen: (previous, current) =>
            previous.saveFailureOrSuccessOption !=
            current.saveFailureOrSuccessOption,
        listener: (context, state) {
          state.saveFailureOrSuccessOption.fold(
            () {},
            (either) => either.fold(
              (failure) => FlushbarHelper.createError(
                  message: failure.map(
                unexpected: (_) =>
                    'Unexpected error occurred while deleting, please contact support.',
                insufficientPermission: (_) => 'Insufficient permissions ❌',
                unableToUpdate: (_) => 'Unable to update',
              )).show(context),
              (_) {
                context.router.replace(const WorkTasksOverviewRoute());
              },
            ),
          );
        },
        buildWhen: (previous, current) => previous.isSaving != current.isSaving,
        builder: (context, state) {
          return Stack(
            children: <Widget>[
              const WorkTaskFormPageScaffold(),
              SavingInProgressOverlay(isSaving: state.isSaving),
            ],
          );
        },
      ),
    );
  }
}

class WorkTaskFormPageScaffold extends StatelessWidget {
  const WorkTaskFormPageScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<WorkTaskFormBloc, WorkTaskFormState>(
          buildWhen: (previous, current) =>
              previous.isSaving != current.isSaving,
          builder: (context, state) =>
              Text(state.isEditing ? "Edit a work task" : "Create a work task"),
        ),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                context
                    .read<WorkTaskFormBloc>()
                    .add(const WorkTaskFormEvent.saved());
              },
              icon: const Icon(Icons.check))
        ],
      ),
      body: BlocBuilder<WorkTaskFormBloc, WorkTaskFormState>(
          buildWhen: (previous, current) =>
              previous.isSaving != current.isSaving,
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 7.0, horizontal: 11),
                    child: Text(
                      "Электронная почта",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                  const NameField(),
                  const SizedBox(height: 12.0),
                  const TypeField(),
                ],
              ),
            );
          }),
    );
  }
}

class SavingInProgressOverlay extends StatelessWidget {
  final bool isSaving;

  const SavingInProgressOverlay({super.key, required this.isSaving});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !isSaving,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        color: isSaving ? Colors.black.withOpacity(0.8) : Colors.transparent,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Visibility(
          visible: isSaving,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const CircularProgressIndicator(),
              const SizedBox(height: 8),
              Text(
                'Saving',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.white,
                      fontSize: 16,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
