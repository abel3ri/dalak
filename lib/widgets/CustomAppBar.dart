// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final List<Widget>? actions;
  final Widget? leading;
  CustomAppBar({
    this.title,
    this.actions,
    this.leading,
  });
  @override
  Widget build(BuildContext context) {
    return AppBar(
      surfaceTintColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      title: Text(title ?? ""),
      actions: actions,
      leading: leading,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
