import 'package:flutter/material.dart';
import 'package:minisitewalkapp/core/constants/app_text_styles.dart';
import 'package:minisitewalkapp/modules/explorer_module/widgets/app_bar/app_bar_base.dart';

class AppBarHowToUse extends StatefulWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? titleWidget;
  final String? leadingText;
  final Widget? leadingWidget;
  final GestureTapCallback? leadingPressed;

  // final GestureTapCallback? howToUsePressed;

  /// if [leadingWidget] is passed then [leadingText] is ignored
  const AppBarHowToUse({
    super.key,
    this.title,
    this.leadingText,
    this.leadingPressed,
    // this.howToUsePressed,
    this.leadingWidget,
    this.titleWidget,
  });

  @override
  State<AppBarHowToUse> createState() => _AppBarHowToUseState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _AppBarHowToUseState extends State<AppBarHowToUse> {
  @override
  Widget build(BuildContext context) {
    final title = widget.title;
    return AppBarBase(
      leadingWidget: widget.leadingWidget,
      leadingPressed: widget.leadingPressed,
      leadingText: widget.leadingText,
      center: widget.titleWidget ??
          (title != null
              ? Text(
                  title,
                  style: AppTextStyles.display18w700,
                )
              : null),
      // trailingWidgets: [
      //   InkWell(
      //     onTap: widget.howToUsePressed,
      //     child: const Text(
      //       'How to use ?',
      //       style: AppTextStyles.linkStyle,
      //     ),
      //   )
      // ],
    );
  }
}
