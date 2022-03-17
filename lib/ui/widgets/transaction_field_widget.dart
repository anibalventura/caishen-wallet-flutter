import 'package:caishen_wallet/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TransactionField extends StatelessWidget {
  const TransactionField({
    Key? key,
    required this.icon,
    required this.title,
    required this.trailingValue,
    this.showTrailingIcon = true,
    this.onTap,
  }) : super(key: key);

  final IconData icon;
  final String title;
  final String trailingValue;
  final bool showTrailingIcon;
  final Function? onTap;

  @override
  Widget build(BuildContext context) {
    const _primaryColor = Colors.blueGrey;

    return InkWell(
      onTap: onTap as VoidCallback?,
      child: Container(
        color: Colors.blueGrey.shade50,
        padding: EdgeInsets.symmetric(
          horizontal: 0.06.sw,
          vertical: 0.02.sh,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  color: _primaryColor,
                ),
                SizedBox(width: 0.02.sw),
                Text(
                  title,
                  style: Utils.theme(context).textTheme.bodyText2!.copyWith(
                        color: _primaryColor,
                      ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  trailingValue,
                  style: Utils.theme(context).textTheme.bodyText1!.copyWith(
                        color: _primaryColor,
                      ),
                ),
                if (showTrailingIcon)
                  const Icon(
                    Icons.keyboard_arrow_right_rounded,
                    color: _primaryColor,
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
