import 'package:flutter/material.dart';

class OnboardingButton extends StatelessWidget {
  final double width;
  final double height;

  final Color? buttonColor;
  final Color? splashColor;
  final double? borderRadius;
  final Widget child;
  final VoidCallback onTap;
  const OnboardingButton(
      {super.key,
      required this.width,
      required this.height,
      this.buttonColor,
      this.borderRadius,
      required this.child,
      required this.onTap,
      this.splashColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius ?? 10),
          color: buttonColor ?? Theme.of(context).colorScheme.primary),
      child: Material(
        borderRadius: BorderRadius.circular(borderRadius ?? 10),
        color: buttonColor ?? Theme.of(context).colorScheme.primary,
        child: InkWell(
          borderRadius: BorderRadius.circular(borderRadius ?? 10),
          onTap: onTap,
          splashColor: splashColor ?? Colors.grey,
          child: child
        ),
      ),
    );
  }
}
