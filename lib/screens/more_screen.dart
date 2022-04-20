import 'dart:io';
import 'package:caishen_wallet/screens/account_screen.dart';
import 'package:caishen_wallet/screens/settings_screen.dart';
import 'package:caishen_wallet/screens/widgets/adaptive_scroll_view.dart';
import 'package:caishen_wallet/screens/widgets/snackbar_widget.dart';
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
        child: AdaptiveScrollView(
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
                title: tr(LocaleTr.moreAccount),
                onTap: () =>
                    Navigator.of(context).pushNamed(AccountScreen.routeName),
              ),
              MoreItem(
                icon: Platform.isAndroid
                    ? Icons.settings_applications_outlined
                    : CupertinoIcons.settings,
                title: tr(LocaleTr.moreSettings),
                onTap: () =>
                    Navigator.of(context).pushNamed(SettingsScreen.routeName),
              ),
              MoreItem(
                icon: Platform.isAndroid
                    ? Icons.star_border
                    : CupertinoIcons.star,
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
      ),
    );
  }
}

class MoreItem extends StatelessWidget {
  const MoreItem({
    Key? key,
    required this.icon,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  final IconData icon;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 0.06.sw,
        ),
        decoration: BoxDecoration(
          color: Colors.blueGrey.shade50,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              icon,
              size: 0.06.sh,
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline1,
            ),
          ],
        ),
      ),
    );
  }
}
