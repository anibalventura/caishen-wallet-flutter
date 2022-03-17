import 'package:caishen_wallet/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void bottomSheet({
  required BuildContext? context,
  EdgeInsetsGeometry? padding,
  List<Widget>? actions,
  List<Widget>? body,
}) {
  showModalBottomSheet<void>(
    context: context!,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (BuildContext context) {
      return Container(
        padding: padding,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          color: Utils.theme(context).scaffoldBackgroundColor,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (actions != null)
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 0.055.sw,
                  vertical: 0.02.sh,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: actions,
                ),
              ),
            Container(
              padding: EdgeInsets.only(
                top: actions == null ? 0.055.sw : 0.sw,
                bottom: 0.02.sh + MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Column(
                children: body!,
              ),
            ),
          ],
        ),
      );
    },
  );
}
