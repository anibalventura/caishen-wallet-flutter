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
    this.dismissDirection,
  }) : super(key: key);

  final String itemKey;
  final Widget child;
  final Color? swipeRightColor;
  final Icon? swipeRightIcon;
  final VoidCallback? swipeRightAction;
  final Color? swipeLeftColor;
  final Icon? swipeLeftIcon;
  final VoidCallback? swipeLeftAction;
  final DismissDirection? dismissDirection;

  @override
  Widget build(BuildContext context) {
    final _padding = EdgeInsets.symmetric(
      horizontal: 0.05.sw,
      vertical: 0.02.sh,
    );
    return Dismissible(
      key: ValueKey(itemKey),
      background: Container(
        decoration: BoxDecoration(
          color: swipeRightColor,
        ),
        alignment: Alignment.centerLeft,
        padding: _padding,
        child: swipeRightIcon,
      ),
      secondaryBackground: Container(
        decoration: BoxDecoration(
          color: swipeLeftColor,
        ),
        alignment: Alignment.centerRight,
        padding: _padding,
        child: swipeLeftIcon,
      ),
      direction: dismissDirection ?? DismissDirection.horizontal,
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
