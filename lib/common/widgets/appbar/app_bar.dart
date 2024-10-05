import 'package:blog_app/common/helpers/is_dark_mode.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title;
  final Widget? trailingButton;
  final Color? backgroundColor;
  final bool hideBackButton;
  const CustomAppBar(
      {super.key,
      this.title,
      this.hideBackButton = false,
      this.trailingButton,
      this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: title ?? const Text(""),
      actions: [trailingButton ?? Container()],
      backgroundColor: backgroundColor ?? Colors.transparent,
      elevation: 0,
      leading: hideBackButton
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
                        ? Colors.grey[800]
                        : Colors.grey[300],
                    shape: BoxShape.circle),
                child: Icon(
                  Icons.arrow_back_ios_new,
                  size: 15,
                  color: context.isDarkMode ? Colors.white : Colors.black,
                ),
              )),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
