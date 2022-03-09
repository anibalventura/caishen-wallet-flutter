import 'package:caishen_wallet/ui/themes.dart';
import 'package:caishen_wallet/utils/utils.dart';
import 'package:flutter/material.dart';

void showSnackbar({
  required BuildContext context,
  required String msg,
  SnackBarBehavior? behavior,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Utils.theme(context).textTheme.headline1!.color,
      duration: const Duration(milliseconds: 2500),
      content: Text(
        msg,
        style: Utils.theme(context).textTheme.bodyText2!.copyWith(
              fontSize: Themes().bodyTextSize,
              color: Utils.theme(context).cardColor,
            ),
      ),
      behavior: behavior ?? SnackBarBehavior.floating,
    ),
  );
}
