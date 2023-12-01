import 'package:flutter/material.dart';
import 'package:minisitewalkapp/core/constants/app_colors.dart';

class AppBarWithLeadingIcon extends StatefulWidget
    implements PreferredSizeWidget {
  final Widget? center;
  final Widget? leadingWidget;
  final GestureTapCallback? leadingPressed;
  final List<Widget>? trailingWidgets;

  const AppBarWithLeadingIcon({
    super.key,
    this.center,
    this.leadingPressed,
    this.trailingWidgets,
    this.leadingWidget,
  });

  @override
  State<AppBarWithLeadingIcon> createState() => _AppBarWithLeadingIconState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _AppBarWithLeadingIconState extends State<AppBarWithLeadingIcon> {
  @override
  Widget build(BuildContext context) {
    final trailingWidgets = widget.trailingWidgets;
    //TODO: reuse the AppBarBase
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
                        child: (widget.leadingWidget != null)
                            ? widget.leadingWidget!
                            : const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                child: Icon(
                                  Icons.chevron_left,
                                  color: AppColors.lightBlue,
                                  size: 28,
                                ),
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
                Expanded(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: trailingWidgets!,
                )),
              ],
            ),
          ),
          const Divider(
            height: 1,
            color: AppColors.lightGrey2,
          )
        ],
      ),
    );
  }
}
