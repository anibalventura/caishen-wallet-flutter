import 'package:caishen_wallet/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void bottomSheet({
  required BuildContext? context,
  Color? backgroundColor,
  List<Widget>? body,
}) {
  showModalBottomSheet<void>(
    context: context!,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (BuildContext context) {
      return Container(
        padding: EdgeInsets.symmetric(
          horizontal: 0.1.sw,
          vertical: 0.05.sh,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          color:
              backgroundColor ?? Utils.theme(context).scaffoldBackgroundColor,
        ),
        child: Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: body!,
          ),
        ),
      );
    },
  );
}
