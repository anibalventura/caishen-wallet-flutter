import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/*
? Helper class that contains several functions to use across the app.
*/

class Utils {
  // Validate that a form can be saved.
  static bool validateForm(GlobalKey<FormState> formKey) {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      return true;
    }

    return false;
  }

  // Get app theme.
  static ThemeData theme(BuildContext context) {
    return Theme.of(context);
  }

  // Check for device landscape mode.
  static bool isLandscape() {
    return ScreenUtil().orientation == Orientation.landscape;
  }
}
