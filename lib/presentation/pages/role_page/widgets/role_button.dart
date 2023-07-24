import 'package:flutter/material.dart';

class RoleButton extends StatelessWidget {
  final String role;
  final Icon icon;
  final Function onPressed;

  const RoleButton({
    super.key,
    required this.role,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120.0,
      width: 120.0,
      child: ElevatedButton(
        onPressed: onPressed(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            Text(
              role,
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
