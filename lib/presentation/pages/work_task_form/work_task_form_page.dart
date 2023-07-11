import 'package:another_flushbar/flushbar_helper.dart';
import 'package:auto_route/auto_route.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_ddd/application/work_tasks/work_task_form/work_task_form_bloc.dart';
import 'package:hello_ddd/domain/work_tasks/work_task.dart';
import 'package:hello_ddd/injection.dart';
import 'package:hello_ddd/presentation/pages/work_task_form/widgets/begin_date_field.dart';
import 'package:hello_ddd/presentation/pages/work_task_form/widgets/description_field.dart';
import 'package:hello_ddd/presentation/pages/work_task_form/widgets/end_date_field.dart';
import 'package:hello_ddd/presentation/pages/work_task_form/widgets/name_field.dart';
import 'package:hello_ddd/presentation/pages/work_task_form/widgets/rating_field.dart';
import 'package:hello_ddd/presentation/pages/work_task_form/widgets/store_field.dart';
import 'package:hello_ddd/presentation/pages/work_task_form/widgets/type_field.dart';
import 'package:hello_ddd/presentation/pages/work_task_form/widgets/worker_card.dart';

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
              previous.isEditing != current.isEditing,
          builder: (context, state) => Text(
              state.isEditing ? "Редактирование заявки" : "Создание заявки"),
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
              previous.showErrorMessages != current.showErrorMessages ||
              previous.workTask.rating != current.workTask.rating,
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
                        "Название заявки",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                    const NameField(),
                    const SizedBox(height: 12.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 7.0, horizontal: 11),
                      child: Text(
                        "Магазин",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                    const StoreField(),
                    const SizedBox(height: 12.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 7.0, horizontal: 11),
                      child: Text(
                        "Вид работ",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                    const TypeField(),
                    const SizedBox(height: 12.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 7.0, horizontal: 11),
                      child: Text(
                        "Дата и время начала работ",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                    const BeginDateField(),
                    const SizedBox(height: 12.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 7.0, horizontal: 11),
                      child: Text(
                        "Дата и время окончания работ",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                    const EndDateField(),
                    const SizedBox(height: 12.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 7.0, horizontal: 11),
                      child: Text(
                        "Примечание",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                    const DescriptionField(),
                    const SizedBox(height: 12.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 7.0, horizontal: 11),
                      child: Text(
                        "Исполнитель",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                    const WorkerCard(),
                    if (context
                        .read<WorkTaskFormBloc>()
                        .state
                        .workTask
                        .completed)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 12.0),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 7.0, horizontal: 11),
                            child: Text(
                              "Оценка выполнения задачи",
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ),
                          const RatingField(),
                        ],
                      ),
                    const SizedBox(height: 32.0),
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
