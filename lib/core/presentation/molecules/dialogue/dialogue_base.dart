import 'package:flutter/material.dart';
import 'package:minisitewalkapp/core/constants/app_colors.dart';
import 'package:minisitewalkapp/core/constants/app_text_styles.dart';
import 'package:minisitewalkapp/core/presentation/atoms/divider_base.dart';

class DialogueBase extends StatelessWidget {
  final String? title;
  final Widget? titleWidget;
  final Widget child;
  final double? maxWidth;
  final Widget? closeWidget;
  final bool showClose;
  final GestureTapCallback? onClose;

  const DialogueBase({
    super.key,
    this.title,
    required this.child,
    this.maxWidth,
    this.closeWidget,
    this.onClose,
    this.titleWidget,
    this.showClose = true,
  }) : assert(title != null || titleWidget != null);

  static show(
    BuildContext context, {
    Key? key,
    required String title,
    required Widget child,
    double? maxWidth,
  }) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return DialogueBase(
          key: key,
          title: title,
          maxWidth: maxWidth,
          child: child,
        );
      },
    );
  }

  static showWithCustomTitle(
    BuildContext context, {
    Key? key,
    double? maxWidth,
    bool showClose = true,
    required Widget title,
    required Widget child,
  }) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return DialogueBase(
          key: key,
          titleWidget: title,
          maxWidth: maxWidth,
          showClose: showClose,
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        constraints: BoxConstraints(
          maxWidth: maxWidth ?? MediaQuery.of(context).size.width * 0.38,
        ),
        padding: const EdgeInsets.only(
          top: 18,
          bottom: 18,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  titleWidget ??
                      Text(
                        title ?? '',
                        style: AppTextStyles.display18w700,
                      ),
                  const Spacer(),
                  if (showClose)
                    InkWell(
                      onTap: () {
                        final onClose = this.onClose;
                        if (onClose != null) {
                          onClose.call();
                        } else {
                          Navigator.pop(context);
                        }
                      },
                      child: closeWidget ??
                          const Icon(
                            Icons.close,
                            color: AppColors.greyIcon,
                          ),
                    ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(
                top: 18,
                bottom: 24,
              ),
              child: DividerBase(),
            ),
            Flexible(
              fit: FlexFit.loose,
              child: child,
            ),
          ],
        ),
      ),
    );
  }
}
