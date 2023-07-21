import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hello_ddd/domain/workers/value_objects.dart';
import 'package:hello_ddd/presentation/pages/role_page/widgets/role_button.dart';

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
              RoleButton(role: WorkerRole.predefinedRoles.worker),
              RoleButton(role: WorkerRole.predefinedRoles.client),
            ],
          ),
        ],
      ),
    );
  }
}
