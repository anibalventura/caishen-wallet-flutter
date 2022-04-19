import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

/// Helper class that contains several functions to use across the app.
class Utils {
  /// Get app theme from /ui/themes.dart
  static ThemeData theme(BuildContext context) {
    return Theme.of(context);
  }

  /// Validate that a form can be saved.
  static bool formIsValid(GlobalKey<FormState> formKey) {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      return true;
    }

    return false;
  }

  /// Date and time format from Milliseconds Since Epoch.
  /// Format => 'MMM d yyyy, hh:mm a'
  static String formatDateAndTimeFromMill(int dateTime) {
    final dateFormat = DateFormat('MMM d yyyy, hh:mm a');
    return dateFormat.format(DateTime.fromMillisecondsSinceEpoch(dateTime));
  }

  /// Date and time format DateTime object.
  /// Format => 'MMM d yyyy, hh:mm a'
  static String formatDateAndTime(DateTime dateTime) {
    final dateFormat = DateFormat('MMM d yyyy, hh:mm a');
    return dateFormat.format(dateTime);
  }

  /// Format amount to money.
  /// Format => r'$ #,###.##'
  static String formatToMoney(double money) {
    final moneyFormat = NumberFormat(r'$ #,###.00');
    return moneyFormat.format(money);
  }
}
