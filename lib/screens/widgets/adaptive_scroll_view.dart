import 'dart:io';
import 'package:caishen_wallet/utils/utils.dart';
import 'package:flutter/cupertino.dart';

class AdaptiveScrollView extends StatelessWidget {
  const AdaptiveScrollView({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoScrollbar(
            child: child,
          )
        : ScrollConfiguration(
            behavior: const ScrollBehavior(),
            child: GlowingOverscrollIndicator(
              color: Utils.theme(context).primaryColor,
              axisDirection: AxisDirection.down,
              child: child,
            ),
          );
  }
}
