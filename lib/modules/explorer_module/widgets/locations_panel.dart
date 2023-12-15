import 'dart:math';

import 'package:flutter/material.dart';
import 'package:minisitewalkapp/core/constants/app_colors.dart';
import 'package:minisitewalkapp/core/constants/app_text_styles.dart';
import 'package:minisitewalkapp/modules/explorer_module/widgets/panel_location_item.dart';

class LocationsPanel extends StatefulWidget {
  final bool isFloating;
  final bool defaultCollapsed;
  // final void Function(FloorPlanLocationEntity) onLocationSelection;
  const LocationsPanel(
      {super.key,
      required this.isFloating,
      // required this.onLocationSelection,
      required this.defaultCollapsed});

  @override
  State<LocationsPanel> createState() => _LocationsPanelState();
}

class _LocationsPanelState extends State<LocationsPanel> {
  double _translateX = 0.0;
  final _width = 278.0;
  final _locationWidth = 248.0;
  bool _hidden = true;

  @override
  void initState() {
    // if isFloating true then hide by default
    _hidden = widget.isFloating && widget.defaultCollapsed;
    _translateX = _hidden ? -_width : 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      transform: Matrix4.translationValues(_translateX, 0.0, 0.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: _width,
            child: Container(
              color: Colors.white,
              padding:
                  const EdgeInsets.symmetric(horizontal: 16).copyWith(top: 24),
              child: Center(
                child: Column(
                  children: [
                    const Text(
                      'Select room to edit floor plan inspection',
                      style: AppTextStyles.display16w400,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Expanded(
                      child: ListView.separated(
                        physics: const ClampingScrollPhysics(),
                        padding: const EdgeInsets.only(bottom: 16),
                        itemBuilder: (c, index) {
                          return PanelLocationItem(
                            key: Key('PanelLocationItem Miguel?'),
                            selected: true,
                            width: _locationWidth,
                            onPressed: () {
                              _togglePanel();
                            },
                          );
                        },
                        itemCount: 2,
                        separatorBuilder: (context, index) => SizedBox(
                          height: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          VerticalDivider(
            width: 1,
            thickness: 1,
            color: AppColors.dividerColor,
          ),
          if (widget.isFloating)
            _ShowHideButton(hidden: _hidden, onPressed: _togglePanel),
        ],
      ),
    );
  }

  void _togglePanel({bool? hidePanel}) {
    setState(() {
      _hidden = hidePanel ?? !_hidden;
      _translateX = _hidden ? -_width : 0;
    });
  }
}

class _ShowHideButton extends StatelessWidget {
  final Function() onPressed;
  final bool hidden;
  const _ShowHideButton({required this.onPressed, required this.hidden});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: 42,
        height: 94,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(12),
            bottomRight: Radius.circular(12),
          ),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(17, 18, 19, 0.28),
              offset: Offset(3, 3),
              blurRadius: 6,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Transform.rotate(
          angle: hidden ? -pi / 2 : pi / 2,
          child: const Icon(
            Icons.arrow_drop_down,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
