import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hello_ddd/domain/workers/value_objects.dart';
import 'package:hello_ddd/presentation/pages/role_page/widgets/role_button.dart';
import 'package:hello_ddd/presentation/routes/router.dart';

@RoutePage()
class RoleSelectionPage extends StatelessWidget {
  const RoleSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              RoleButton(
                role: WorkerRole.predefinedRoles.worker,
                icon: const Icon(
                  Icons.handyman,
                  size: 80.0,
                ),
                onPressed: () {
                  context.router.replace(const WorkTasksOverviewRoute());
                },
              ),
              RoleButton(
                role: WorkerRole.predefinedRoles.client,
                icon: const Icon(
                  Icons.account_box_rounded,
                  size: 80.0,
                ),
                onPressed: () {
                  // TODO: change from SplashRoute to smthng
                  context.router.replace(const SplashRoute());
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
