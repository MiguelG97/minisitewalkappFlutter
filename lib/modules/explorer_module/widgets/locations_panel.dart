import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minisitewalkapp/core/constants/app_colors.dart';
import 'package:minisitewalkapp/core/constants/app_text_styles.dart';
import 'package:minisitewalkapp/modules/explorer_module/bloc/viewer_bloc.dart';
import 'package:minisitewalkapp/modules/explorer_module/bloc/viewer_states.dart';
import 'package:minisitewalkapp/modules/explorer_module/models/room_model.dart';
import 'package:minisitewalkapp/modules/explorer_module/widgets/panel_location_item.dart';

class LocationsPanel extends StatefulWidget {
  // final void Function(FloorPlanLocationEntity) onLocationSelection;

  const LocationsPanel({
    super.key,
    // required this.onLocationSelection,
  });

  @override
  State<LocationsPanel> createState() => _LocationsPanelState();
}

class _LocationsPanelState extends State<LocationsPanel> {
  final _width = 278.0;
  final _locationWidth = 248.0;
  bool _hidden = true; //panel hidden
  late double _translateX;
  @override
  void initState() {
    // TODO: implement initState
    _translateX = -_width;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ViewerBloc, ViewerState>(
      // bloc: BlocProvider.of(context),
      builder: (context, state) {
        List<dynamic> roomItems = [];

        //a) load data and open the room panel
        if (state is ViewPreInitialized) {
          // _togglePanel();//can not call set state if its triggered by a bloc state builder!
          roomItems = state.roomItems;
          if (state.isLandingPage) {
            _hidden = !_hidden;
            _translateX = _hidden ? -_width : 0;
            state.isLandingPage = false;
          }
        }

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
                  padding: const EdgeInsets.symmetric(horizontal: 16)
                      .copyWith(top: 24),
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
                              Room roomItem = roomItems[index];

                              return PanelLocationItem(
                                key: Key('PanelLocationItem Miguel?'),
                                roomName: roomItem.name,
                                selected: true,
                                width: _locationWidth,
                                onPressed: () {
                                  _togglePanel(); //on any room selection, hide the panel too!
                                },
                              );
                            },
                            itemCount: roomItems.length,
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
              //the button to open the panel in case it is hiden
              VerticalDivider(
                width: 1,
                thickness: 1,
                color: AppColors.dividerColor,
              ),
              _ShowHideButton(hidden: _hidden, onPressed: _togglePanel),
            ],
          ),
        );
      },
    );
  }

  void _togglePanel() {
    setState(() {
      _hidden = !_hidden;
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
