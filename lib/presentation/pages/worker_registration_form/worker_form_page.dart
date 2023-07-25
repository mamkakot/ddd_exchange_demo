import 'package:another_flushbar/flushbar_helper.dart';
import 'package:auto_route/auto_route.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_ddd/application/worker/worker_form/worker_form_bloc.dart';
import 'package:hello_ddd/domain/workers/worker.dart';
import 'package:hello_ddd/injection.dart';
import 'package:hello_ddd/presentation/pages/worker_registration_form/widgets/name_field.dart';
import 'package:hello_ddd/presentation/pages/worker_registration_form/widgets/position_field.dart';

@RoutePage()
class WorkerFormPage extends StatelessWidget {
  final Worker? editedWorker;

  const WorkerFormPage({super.key, required this.editedWorker});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<WorkerFormBloc>()
        ..add(WorkerFormEvent.initialized(optionOf(editedWorker))),
      child: BlocConsumer<WorkerFormBloc, WorkerFormState>(
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
                    'Произошла неожиданная ошибка, свяжитесь с поддержкой',
                insufficientPermission: (_) => 'Недостаточно прав ❌',
                unableToUpdate: (_) => 'Невоможно обновить',
              )).show(context),
              (_) {
                context.router.pop();
              },
            ),
          );
        },
        buildWhen: (previous, current) => previous.isSaving != current.isSaving,
        builder: (context, state) {
          return Stack(
            children: [
              const WorkerFormPageScaffold(),
              SavingInProgressOverlay(isSaving: state.isSaving),
            ],
          );
        },
      ),
    );
  }
}

class WorkerFormPageScaffold extends StatelessWidget {
  const WorkerFormPageScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<WorkerFormBloc, WorkerFormState>(
          buildWhen: (previous, current) =>
              previous.isEditing != current.isEditing,
          builder: (context, state) => Text(
              state.isEditing ? "Редактирование заявки" : "Создание заявки"),
        ),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                context
                    .read<WorkerFormBloc>()
                    .add(const WorkerFormEvent.saved());
              },
              icon: const Icon(Icons.check))
        ],
      ),
      body: BlocBuilder<WorkerFormBloc, WorkerFormState>(
          buildWhen: (previous, current) =>
              previous.showErrorMessages != current.showErrorMessages,
          builder: (context, state) {
            return Form(
              autovalidateMode: state.showErrorMessages
                  ? AutovalidateMode.always
                  : AutovalidateMode.disabled,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    const SizedBox(height: 32.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 7.0, horizontal: 11),
                      child: Text(
                        "Полное имя",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                    const NameField(),
                    const SizedBox(height: 12.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 7.0, horizontal: 11),
                      child: Text(
                        "Должность",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                    const PositionField(),
                  ],
                ),
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
                'Идёт сохранение...',
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
