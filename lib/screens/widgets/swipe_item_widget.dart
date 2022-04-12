import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SwipeItem extends StatelessWidget {
  const SwipeItem({
    Key? key,
    required this.itemKey,
    required this.child,
    this.swipeRightColor,
    this.swipeRightIcon,
    this.swipeRightAction,
    this.swipeLeftColor,
    this.swipeLeftIcon,
    this.swipeLeftAction,
  }) : super(key: key);

  final String itemKey;
  final Widget child;
  final Color? swipeRightColor;
  final Icon? swipeRightIcon;
  final Function? swipeRightAction;
  final Color? swipeLeftColor;
  final Icon? swipeLeftIcon;
  final Function? swipeLeftAction;

  @override
  Widget build(BuildContext context) {
    final _borderRadius = BorderRadius.circular(30.r);
    final _padding = EdgeInsets.symmetric(
      horizontal: 0.05.sw,
      vertical: 0.02.sh,
    );
    final _margin = EdgeInsets.symmetric(
      horizontal: 0.05.sw,
      vertical: 0.01.sh,
    );

    return Dismissible(
      key: ValueKey(itemKey),
      background: Container(
        decoration: BoxDecoration(
          color: swipeRightColor,
          borderRadius: _borderRadius,
        ),
        alignment: Alignment.centerLeft,
        padding: _padding,
        margin: _margin,
        child: swipeRightIcon,
      ),
      secondaryBackground: Container(
        decoration: BoxDecoration(
          color: swipeLeftColor,
          borderRadius: _borderRadius,
        ),
        alignment: Alignment.centerRight,
        padding: _padding,
        margin: _margin,
        child: swipeLeftIcon,
      ),
      direction: swipeRightAction != null
          ? DismissDirection.startToEnd
          : DismissDirection.endToStart,
      confirmDismiss: (direction) async {
        switch (direction) {
          case DismissDirection.startToEnd:
            // ignore: avoid_dynamic_calls
            swipeRightAction!.call();
            break;
          case DismissDirection.endToStart:
            // ignore: avoid_dynamic_calls
            swipeLeftAction!.call();
            break;
          // ignore: no_default_cases
          default:
            return false;
        }
        return null;
      },
      child: child,
    );
  }
}
