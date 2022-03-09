import 'package:caishen_wallet/ui/themes.dart';
import 'package:caishen_wallet/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RoundButton extends StatelessWidget {
  const RoundButton({
    Key? key,
    required this.title,
    required this.onPressed,
    this.icon,
    this.iconColor,
    this.buttonColor,
  }) : super(key: key);

  final String title;
  final Function onPressed;
  final IconData? icon;
  final Color? iconColor;
  final Color? buttonColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed as VoidCallback,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
          buttonColor ?? Utils.theme(context).colorScheme.secondary,
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.r),
          ),
        ),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: Utils.isLandscape() ? 0.02.sh : 0.012.sh,
        ),
        constraints: BoxConstraints(
          minWidth: Utils.isLandscape() ? 0.05.sw : 0.12.sw,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) Icon(icon, color: iconColor ?? Colors.white),
            if (icon != null)
              SizedBox(width: Utils.isLandscape() ? 0.01.sw : 0.02.sw),
            Text(
              title,
              style: Utils.theme(context).textTheme.bodyText2!.copyWith(
                    fontSize: Themes().bodyTextSize,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
