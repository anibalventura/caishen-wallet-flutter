import 'dart:io';

import 'package:caishen_wallet/ui/screens/profile_screen.dart';
import 'package:caishen_wallet/ui/widgets/more_item_widget.dart';
import 'package:caishen_wallet/ui/widgets/snackbar_widget.dart';
import 'package:caishen_wallet/utils/localizations.dart';
import 'package:caishen_wallet/utils/utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({
    Key? key,
  }) : super(key: key);

  static const String routeName = '/more_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GridView(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            childAspectRatio: 5 / 3,
            maxCrossAxisExtent: 0.5.sw,
            mainAxisSpacing: 0.04.sh,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 0.05.sw,
            vertical: 0.02.sh,
          ),
          children: [
            MoreItem(
              icon: Platform.isAndroid
                  ? Icons.person_outline
                  : CupertinoIcons.person,
              title: tr(LocaleTr.moreProfile),
              onTap: () =>
                  Navigator.of(context).pushNamed(ProfileScreen.routeName),
            ),
            MoreItem(
              icon: Platform.isAndroid
                  ? Icons.settings_applications_outlined
                  : CupertinoIcons.settings,
              title: tr(LocaleTr.moreSettings),
              onTap: () => showSnackbar(
                context: context,
                msg: 'Coming soon!',
                color: Utils.theme(context).colorScheme.primary,
              ),
            ),
            MoreItem(
              icon:
                  Platform.isAndroid ? Icons.star_border : CupertinoIcons.star,
              title: tr(LocaleTr.moreAbout),
              onTap: () => showSnackbar(
                context: context,
                msg: 'Coming soon!',
                color: Utils.theme(context).colorScheme.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
