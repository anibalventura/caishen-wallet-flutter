import 'dart:io';

import 'package:caishen_wallet/utils/localizations.dart';
import 'package:caishen_wallet/utils/utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void adaptiveActionBottomSheet({
  required BuildContext context,
  String? title,
  String? message,
  List<Widget>? actions,
  List<CupertinoActionSheetAction>? cupertinoActions,
}) {
  final barrierColor = Colors.grey.withOpacity(0.8);
  final textTitle = Text(
    title!,
    style: Utils.theme(context).textTheme.headline1,
  );
  final textMessage = Text(
    message!,
    style: Utils.theme(context).textTheme.bodyText1,
  );

  Platform.isIOS
      ? showCupertinoModalPopup<void>(
          context: context,
          barrierColor: barrierColor,
          builder: (BuildContext context) => CupertinoActionSheet(
            title: textTitle,
            message: textMessage,
            actions: cupertinoActions,
            cancelButton: CupertinoActionSheetAction(
              onPressed: () => Navigator.pop(context),
              child: Text(
                tr(LocaleTr.cancel),
                style: TextStyle(color: Utils.theme(context).errorColor),
              ),
            ),
          ),
        )
      : showModalBottomSheet<bool>(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          barrierColor: barrierColor,
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
                  textTitle,
                  SizedBox(height: 0.005.sh),
                  textMessage,
                  SizedBox(height: 0.02.sh),
                  ...actions!,
                  SizedBox(height: 0.02.sh),
                ],
              ),
            );
          },
        );
}
