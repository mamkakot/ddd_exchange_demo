import 'package:flutter/material.dart';
import 'package:hello_ddd/domain/workers/value_objects.dart';

class RoleButton extends StatelessWidget {
  final String role;

  const RoleButton({super.key, required this.role});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120.0,
      width: 120.0,
      child: ElevatedButton(
        onPressed: () {},
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              coolCase(
                role,
                {
                  WorkerRole.predefinedRoles.worker: Icons.handyman,
                  WorkerRole.predefinedRoles.client: Icons.account_box_rounded,
                },
              ),
              size: 80.0,
            ),
            Text(
              coolCase(
                role,
                {
                  WorkerRole.predefinedRoles.worker: "Исполнитель",
                  WorkerRole.predefinedRoles.client: "Заказчик",
                },
              )!,
              style: Theme.of(context)
                  .textTheme
                  .labelMedium
                  ?.copyWith(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

TValue? coolCase<TOptionType, TValue>(
  TOptionType selectedOption,
  Map<TOptionType, TValue> branches, [
  TValue? defaultValue,
]) {
  if (!branches.containsKey(selectedOption)) {
    return defaultValue;
  }

  return branches[selectedOption];
}
