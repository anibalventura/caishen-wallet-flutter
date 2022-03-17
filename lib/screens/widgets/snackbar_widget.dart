import 'package:caishen_wallet/utils/utils.dart';
import 'package:flutter/material.dart';

void showSnackbar({
  required BuildContext context,
  required String msg,
  required Color color,
  SnackBarBehavior? behavior,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: color,
      duration: const Duration(milliseconds: 2500),
      content: Text(
        msg,
        style: Utils.theme(context).textTheme.bodyText2!.copyWith(
              color: Colors.white,
            ),
      ),
      behavior: behavior ?? SnackBarBehavior.floating,
    ),
  );
}
