import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final double width;
  final double height;

  final Color? buttonColor;
  final Color? splashColor;
  final Color? iconColor;
  final double iconSize;
  final double? borderRadius;
  final IconData myIcon;
  final VoidCallback onTap;
  const MyButton(
      {super.key,
      required this.width,
      required this.height,
      this.buttonColor,
      this.iconColor,
      required this.iconSize,
      this.borderRadius,
      required this.myIcon,
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
          child: Icon(
            myIcon,
            color: iconColor ?? Theme.of(context).colorScheme.onPrimary,
            size: iconSize,
          ),
        ),
      ),
    );
  }
}
