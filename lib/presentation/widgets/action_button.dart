import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final void Function() onClick;
  final IconData iconData;
  final double iconSize;
  final Color? backgroundColor;
  final Color? iconColor;

  const ActionButton({
    super.key,
    required this.iconData,
    required this.onClick,
    required this.iconSize,
    this.backgroundColor,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(50),
      clipBehavior: Clip.hardEdge,
      elevation: 16,
      color: backgroundColor ?? Theme.of(context).colorScheme.primary,
      child: InkWell(
        onTap: onClick,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Icon(
            iconData,
            color: iconColor ?? Colors.white,
            size: iconSize,
          ),
        ),
      ),
    );
  }
}
