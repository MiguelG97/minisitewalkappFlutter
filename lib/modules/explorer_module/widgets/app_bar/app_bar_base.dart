import 'package:flutter/material.dart';
import 'package:minisitewalkapp/core/constants/app_colors.dart';
import 'package:minisitewalkapp/core/constants/app_text_styles.dart';
import 'package:minisitewalkapp/core/presentation/atoms/divider_base.dart';

class AppBarBase extends StatefulWidget implements PreferredSizeWidget {
  final Widget? center;
  final String? leadingText;
  final Widget? leadingWidget;
  final GestureTapCallback? leadingPressed;
  final List<Widget>? trailingWidgets;

  /// if [leadingWidget] is passed then [leadingText] is ignored
  const AppBarBase({
    super.key,
    this.center,
    this.leadingText,
    this.leadingPressed,
    this.trailingWidgets,
    this.leadingWidget,
  }) : assert(leadingText == null || leadingWidget == null,
            "Only leadingText or leadingWidget should be provided");

  @override
  State<AppBarBase> createState() => _AppBarBaseState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _AppBarBaseState extends State<AppBarBase> {
  @override
  Widget build(BuildContext context) {
    final trailingWidgets = widget.trailingWidgets;
    return Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.only(right: 16),
            height: widget.preferredSize.height - 1,
            child: Row(
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: InkWell(
                      onTap: () {
                        if (widget.leadingPressed == null) {
                          if (Navigator.canPop(context)) {
                            Navigator.pop(context);
                          }
                        } else {
                          //Call the method passed from param
                          widget.leadingPressed?.call();
                        }
                      },
                      child: SizedBox(
                        height: double.maxFinite,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8)
                                  .copyWith(
                                      right: widget.leadingWidget != null ||
                                              widget.leadingText != null
                                          ? 8
                                          : 16),
                              child: const Icon(
                                Icons.chevron_left,
                                color: AppColors.lightBlue,
                                size: 28,
                              ),
                            ),
                            if (widget.leadingWidget != null)
                              Expanded(child: widget.leadingWidget!)
                            else if (widget.leadingText != null)
                              Text(
                                widget.leadingText!,
                                style: AppTextStyles.display18w500,
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                if (widget.center != null)
                  Expanded(
                    child: Center(
                      child: widget.center,
                    ),
                  ),
                if (widget.trailingWidgets != null || widget.center != null)
                  Expanded(
                    child: trailingWidgets != null
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: trailingWidgets,
                          )
                        : const SizedBox(),
                  ),
              ],
            ),
          ),
          const DividerBase()
        ],
      ),
    );
  }
}
