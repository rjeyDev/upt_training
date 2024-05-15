import 'package:flutter/material.dart';
import 'package:upt_training/ui_kit/app_color.dart';

class SecondaryButton extends StatelessWidget {
  final Widget child;
  final Function() onPressed;
  const SecondaryButton({
    super.key,
    required this.onPressed,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        decoration: BoxDecoration(
          color: AppColor.primary.withOpacity(0.6),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(child: child),
      ),
    );
  }
}
