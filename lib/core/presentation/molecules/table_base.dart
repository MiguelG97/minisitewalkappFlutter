import 'package:flutter/material.dart';
import 'package:minisitewalkapp/core/presentation/atoms/v_space.dart';

///Use [TableBaseCell] while adding cells to this table.
///Use it for both header and data cells.
class TableBase extends StatelessWidget {
  final int rowCount;
  final IndexedWidgetBuilder rowItemBuilder;
  final IndexedWidgetBuilder? separatorBuilder;

  const TableBase({
    Key? key,
    required this.rowCount,
    required this.rowItemBuilder,
    this.separatorBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxHeight: 350),
      child: ListView.separated(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        shrinkWrap: true,
        itemCount: rowCount,
        itemBuilder: rowItemBuilder,
        separatorBuilder: separatorBuilder ??
            (BuildContext context, int index) {
              return VSpace.h16();
            },
      ),
    );
  }
}

class TableBaseCell extends StatelessWidget {
  final int? flex;
  final Widget cell;
  final bool? shrink;

  const TableBaseCell({
    Key? key,
    this.flex,
    required this.cell,
    this.shrink,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex ?? 1,
      child: (shrink ?? true)
          ? Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 4),
                  child: cell,
                ),
                const Spacer(),
              ],
            )
          : Padding(
              padding: const EdgeInsets.only(right: 4),
              child: cell,
            ),
    );
  }
}
