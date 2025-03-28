import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title;
  final List<Widget>? actions;
  final void Function()? onBack;

  const CustomAppBar({
    super.key,
    this.title,
    this.actions,
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title,
      backgroundColor: Theme.of(context).colorScheme.surface,
      surfaceTintColor: Theme.of(context).colorScheme.surface,
      shadowColor: Theme.of(context).colorScheme.outlineVariant,
      automaticallyImplyLeading: false,
      actions: actions,
      // Leadings are mostly used for BackButtons for now..
      leading: onBack != null
          ? IconButton(
              onPressed: onBack,
              icon: Icon(Icons.arrow_back),
            )
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
