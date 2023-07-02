import 'package:another_flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_ddd/application/auth/auth_bloc.dart';
import 'package:hello_ddd/application/work_tasks/work_task_actor/work_task_actor_bloc.dart';
import 'package:hello_ddd/application/work_tasks/work_task_watcher/work_task_watcher_bloc.dart';
import 'package:hello_ddd/injection.dart';
import 'package:auto_route/auto_route.dart';
import 'package:hello_ddd/presentation/pages/work_tasks/widgets/work_tasks_overview_body.dart';
import 'package:hello_ddd/presentation/routes/router.dart';

@RoutePage()
class WorkTasksOverviewPage extends StatelessWidget {
  const WorkTasksOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<WorkTaskWatcherBloc>(
              create: (context) => getIt<WorkTaskWatcherBloc>()
                ..add(const WorkTaskWatcherEvent.watchAllStarted())),
          BlocProvider<WorkTaskActorBloc>(
              create: (context) => getIt<WorkTaskActorBloc>()),
        ],
        child: MultiBlocListener(
          listeners: [
            BlocListener<AuthBloc, AuthState>(listener: (context, state) {
              state.maybeMap(
                  orElse: () {},
                  unauthenticated: (_) =>
                      AutoRouter.of(context).replace(const SignInRoute()));
            }),
            BlocListener<WorkTaskActorBloc, WorkTaskActorState>(
                listener: (context, state) {
              state.maybeMap(
                  orElse: () {},
                  deleteFailure: (state) => FlushbarHelper.createError(
                          message: state.workTaskFailure.map(
                        unexpected: (_) =>
                            'Unexpected error occurred while deleting, please contact support.',
                        insufficientPermission: (_) =>
                            'Insufficient permissions ❌',
                        unableToUpdate: (_) => 'Unable to update',
                      )).show(context));
            })
          ],
          child: Scaffold(
            appBar: AppBar(
              title: const Text("Work tasks"),
              leading: IconButton(
                icon: const Icon(Icons.exit_to_app),
                onPressed: () {
                  context.read<AuthBloc>().add(const AuthEvent.signedOut());
                },
              ),
              actions: <Widget>[
                IconButton(
                  icon: const Icon(Icons.indeterminate_check_box),
                  onPressed: () {},
                )
              ],
            ),
            body: WorkTasksOverviewBody(),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                // TODO: Navigate to WorkTaskFormPage
              },
              child: const Icon(Icons.add),
            ),
          ),
        ));
  }
}
