import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:minisitewalkapp/core/constants/app_colors.dart';

enum InspectionStatus {
  pending('pending'),
  inprogress('inprogress'),
  completed('completed');

  final String strRep;

  const InspectionStatus(this.strRep);

  Color getColor() {
    switch (this) {
      case InspectionStatus.pending:
        return AppColors.greyD9;
      case InspectionStatus.inprogress:
        return AppColors.orangeFFAB00;
      case InspectionStatus.completed:
        return AppColors.green00B779;
    }
  }

  String getColorHex() {
    switch (this) {
      case InspectionStatus.pending:
        return '#D9D9D9';
      case InspectionStatus.inprogress:
        return '#FFAB00';
      case InspectionStatus.completed:
        return '#00B779';
    }
  }

  Color getTextColor() {
    switch (this) {
      case InspectionStatus.pending:
        return AppColors.black;
      case InspectionStatus.inprogress:
        return AppColors.orangeFFAB00;
      case InspectionStatus.completed:
        return AppColors.green00B779;
    }
  }

  String getDisplayText() {
    switch (this) {
      case InspectionStatus.pending:
        return 'Pending';
      case InspectionStatus.inprogress:
        return 'In-Progress';
      case InspectionStatus.completed:
        return 'Completed';
    }
  }

  factory InspectionStatus.getStatusFrom(String strVal) {
    return InspectionStatus.values
            .firstWhereOrNull((element) => element.strRep == strVal) ??
        InspectionStatus.pending;
  }

  Color getBackgroundColor() {
    switch (this) {
      case InspectionStatus.pending:
        return AppColors.greyD9;
      case InspectionStatus.inprogress:
        return AppColors.orangeFFAB00.withAlpha(80);
      case InspectionStatus.completed:
        return AppColors.greenAEE9D1;
    }
  }
}
