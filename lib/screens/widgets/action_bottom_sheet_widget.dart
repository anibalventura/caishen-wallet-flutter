import 'package:caishen_wallet/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void actionBottomSheet({
  required BuildContext context,
  String? title,
  String? message,
  List<Widget>? actions,
}) {
  showModalBottomSheet<bool>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (BuildContext context) {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          color: Utils.theme(context).scaffoldBackgroundColor,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 0.03.sw,
          vertical: 0.05.sh,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title!,
              style: Utils.theme(context).textTheme.headline1,
            ),
            SizedBox(height: 0.005.sh),
            Text(
              message!,
              style: Utils.theme(context).textTheme.bodyText1,
            ),
            SizedBox(height: 0.02.sh),
            ...actions!,
            SizedBox(height: 0.02.sh),
          ],
        ),
      );
    },
  );
}
