import 'package:caishen_wallet/utils/localizations.dart';
import 'package:caishen_wallet/utils/utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

class LiquidProgressIndicator extends StatelessWidget {
  const LiquidProgressIndicator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 0.04.sh,
        width: 0.4.sw,
        child: LiquidLinearProgressIndicator(
          valueColor: AlwaysStoppedAnimation(
            Utils.theme(context).colorScheme.primary,
          ),
          borderColor: Utils.theme(context).colorScheme.secondary,
          borderWidth: 1.5.r,
          borderRadius: 30.r,
          center: Text(
            tr(LocaleTr.loading),
            style: Utils.theme(context).textTheme.bodyText2,
          ),
        ),
      ),
    );
  }
}
