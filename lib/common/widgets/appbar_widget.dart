import 'package:flutter/material.dart';

class AppbarWidget extends StatelessWidget implements PreferredSizeWidget {
  final BuildContext context;
  final String title;
  final bool themeIcon;
  final Function()? onBackPressed;
  final List<Widget>? actions;

  const AppbarWidget({super.key, required this.context, required this.title, required this.themeIcon, this.onBackPressed, this.actions});

  @override
  Size get preferredSize => Size(double.infinity, AppBar().preferredSize.height);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: title.isNotEmpty,
      centerTitle: false,
      elevation: title.isNotEmpty ? 3.0 : 0.0,
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white, fontWeight: FontWeight.w500),
      ),
      leading: onBackPressed != null
          ? InkWell(
              onTap: () => onBackPressed != null ? onBackPressed!() : null,
              child: Padding(padding: const EdgeInsets.all(15.0), child: Icon(Icons.arrow_back_ios_new_rounded)),
            )
          : null,
      backgroundColor: title.isNotEmpty ? Theme.of(context).colorScheme.primary.withValues(alpha: 0.8) : Colors.transparent,
      surfaceTintColor: Theme.of(context).colorScheme.surface,
      foregroundColor: Theme.of(context).colorScheme.surface,
      actions: [...?actions],
    );
  }
}
