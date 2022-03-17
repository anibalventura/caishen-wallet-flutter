import 'dart:io' show Platform;
import 'package:caishen_wallet/utils/localizations.dart';
import 'package:caishen_wallet/utils/utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<void> adaptiveDatePicker({
  required BuildContext context,
  required DateTime minimumDate,
  required DateTime maximumDate,
  required ValueChanged<DateTime> onDateSelected,
  CupertinoDatePickerMode? mode,
  DateTime? initialDate,
}) async {
  return Platform.isIOS
      ? await showModalBottomSheet(
          context: context,
          builder: (builder) {
            return Container(
              height: 0.4.sh,
              color: Utils.theme(context).cardColor,
              child: CupertinoDatePicker(
                initialDateTime: initialDate ?? DateTime.now(),
                minimumYear: minimumDate.year,
                maximumYear: maximumDate.year,
                mode: mode ?? CupertinoDatePickerMode.date,
                onDateTimeChanged: (picked) => onDateSelected(picked),
              ),
            );
          },
        )
      : await showDatePicker(
          context: context,
          initialDate: initialDate ?? DateTime.now(),
          firstDate: minimumDate,
          lastDate: maximumDate,
          confirmText: tr(LocaleTr.datePickerSelect).toUpperCase(),
          helpText: tr(LocaleTr.datePickerSelectDate).toUpperCase(),
          fieldLabelText: tr(LocaleTr.datePickerSelectDate).toUpperCase(),
          builder: (context, child) => child!,
        ).then((picked) => onDateSelected(picked!));
}
