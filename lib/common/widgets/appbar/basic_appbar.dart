import 'package:flutter/material.dart';
import 'package:spotify/common/helpers/is_dark_mode.dart';

class BasicAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title;
  final Widget? action;
  final Color? backgroundColour;
  final bool hideBack;
  const BasicAppBar({
    this.title,
    this.backgroundColour,
    this.hideBack = false,
    this.action,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: backgroundColour ?? Colors.transparent,
      title: title ?? const Text(''),
      centerTitle: true,
      actions: [
        action ?? Container(),
      ],
      leading: hideBack
          ? null
          : IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: context.isDarkMode
                      ? Colors.white.withOpacity(0.03)
                      : Colors.black.withOpacity(0.04),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.arrow_back_ios,
                  size: 15,
                  color: context.isDarkMode ? Colors.white : Colors.black,
                ),
              ),
            ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
