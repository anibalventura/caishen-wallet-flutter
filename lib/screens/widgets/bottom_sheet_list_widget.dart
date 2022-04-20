import 'package:caishen_wallet/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void bottomSheetList({
  required BuildContext? context,
  EdgeInsetsGeometry? padding,
  List<Widget>? actions,
  Widget? body,
}) {
  showModalBottomSheet<void>(
    context: context!,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (BuildContext context) {
      return DraggableScrollableSheet(
        expand: false,
        builder: (context, scrollController) {
          return Container(
            padding: padding,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
              color: Utils.theme(context).scaffoldBackgroundColor,
            ),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    margin: EdgeInsets.only(top: 0.02.sh),
                    height: 0.01.sh,
                    width: 0.2.sw,
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                if (actions != null)
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 0.055.sw,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: actions,
                    ),
                  ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(
                      top: actions == null ? 0.055.sw : 0.sw,
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                    ),
                    child: body,
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}
