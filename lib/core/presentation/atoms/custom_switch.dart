import 'package:flutter/material.dart';
import 'package:minisitewalkapp/core/constants/app_colors.dart';
import 'package:minisitewalkapp/core/constants/app_text_styles.dart';

class CustomSwitch extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final bool disabled;
  final Function()? onClickWhenDisabled;

  const CustomSwitch({
    Key? key,
    required this.value,
    required this.onChanged,
    this.disabled = false,
    this.onClickWhenDisabled,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CustomSwitchState createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch>
    with SingleTickerProviderStateMixin {
  Animation? _circleAnimation;
  AnimationController? _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 60));
    _circleAnimation = AlignmentTween(
            begin: widget.value ? Alignment.centerRight : Alignment.centerLeft,
            end: widget.value ? Alignment.centerLeft : Alignment.centerRight)
        .animate(CurvedAnimation(
            parent: _animationController!, curve: Curves.linear));
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (widget.disabled) {
          widget.onClickWhenDisabled?.call();
        }
      },
      child: IgnorePointer(
        ignoring: widget.disabled,
        child: AnimatedBuilder(
          animation: _animationController!,
          builder: (context, child) {
            return GestureDetector(
              onTap: () {
                if (_animationController!.isCompleted) {
                  _animationController!.reverse();
                } else {
                  _animationController!.forward();
                }
                widget.value == false
                    ? widget.onChanged(true)
                    : widget.onChanged(false);
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 48.0,
                    height: 24.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      color: _circleAnimation!.value == Alignment.centerLeft
                          ? AppColors.grey8C9196
                          : AppColors.green00B779,
                    ),
                    child: Stack(
                      children: [
                        const Align(
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 18,
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Icon(
                                Icons.close,
                                color: Colors.white,
                                size: 18,
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 3, bottom: 3, right: 3, left: 3),
                          child: Container(
                            alignment: _circleAnimation!.value,
                            child: Container(
                              width: 18.0,
                              height: 18.0,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  SizedBox(
                    width: 25,
                    child: Text(
                      _circleAnimation!.value == Alignment.centerRight
                          ? 'Yes'
                          : 'No',
                      style: AppTextStyles.display14w400Black23,
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
