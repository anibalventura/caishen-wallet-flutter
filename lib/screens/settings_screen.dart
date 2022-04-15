import 'dart:io';
import 'package:caishen_wallet/screens/edit_list_screen.dart';
import 'package:caishen_wallet/utils/localizations.dart';
import 'package:caishen_wallet/utils/utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum SettingsEnum { categories, paymentTypes }

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({
    Key? key,
  }) : super(key: key);

  static const String routeName = '/settings_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tr(LocaleTr.moreSettings)),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            SettingsItem(
              title: tr(LocaleTr.settingsCategories),
              leadingIcon: Platform.isAndroid
                  ? Icons.folder_open_outlined
                  : CupertinoIcons.folder,
              onTap: () => Navigator.pushNamed(
                context,
                EditListScreen.routeName,
                arguments: SettingsEnum.categories,
              ),
            ),
            SettingsItem(
              title: tr(LocaleTr.settingsPaymentTypes),
              leadingIcon: Platform.isAndroid
                  ? Icons.credit_card
                  : CupertinoIcons.creditcard,
              onTap: () => Navigator.pushNamed(
                context,
                EditListScreen.routeName,
                arguments: SettingsEnum.paymentTypes,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SettingsItem extends StatelessWidget {
  const SettingsItem({
    Key? key,
    required this.title,
    required this.onTap,
    this.leadingIcon,
  }) : super(key: key);

  final String title;
  final VoidCallback onTap;
  final IconData? leadingIcon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        leadingIcon,
        color: Utils.theme(context).colorScheme.secondary,
      ),
      title: Text(title),
      trailing: Icon(
        Platform.isAndroid ? Icons.arrow_forward : Icons.arrow_forward_ios,
      ),
      onTap: onTap,
    );
  }
}
