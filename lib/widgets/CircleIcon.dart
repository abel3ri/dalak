import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

class CircleIcon extends StatelessWidget {
  final IconData icon;
  final void Function()? onPressed;
  const CircleIcon({
    required this.icon,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Stack(
      alignment: Alignment.center,
      children: [
        CircleAvatar(
          backgroundColor: isDarkMode
              ? Theme.of(context).scaffoldBackgroundColor.lighten(10)
              : Theme.of(context).scaffoldBackgroundColor.darken(10),
        ),
        IconButton(
          onPressed: onPressed,
          icon: Icon(icon),
        ),
      ],
    );
  }
}
