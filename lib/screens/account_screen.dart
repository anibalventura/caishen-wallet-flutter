import 'dart:io';
import 'package:caishen_wallet/screens/widgets/adaptive_action_bottom_sheet_widget.dart';
import 'package:caishen_wallet/screens/widgets/adaptive_scroll_view.dart';
import 'package:caishen_wallet/screens/widgets/bottom_sheet_widget.dart';
import 'package:caishen_wallet/screens/widgets/outline_form_field_widget.dart';
import 'package:caishen_wallet/screens/widgets/round_button_widget.dart';
import 'package:caishen_wallet/services/auth.dart';
import 'package:caishen_wallet/utils/localizations.dart';
import 'package:caishen_wallet/utils/utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AccountScreen extends StatelessWidget {
  AccountScreen({
    Key? key,
  }) : super(key: key);

  static const String routeName = '/account_screen';

  final User? user = Auth.auth.currentUser;

  @override
  Widget build(BuildContext context) {
    String? newEmail;
    String? newPassword;

    Future<void> deleteAccount() async {
      Navigator.of(context).pop();
      await Auth.deleteAccount();
      Navigator.of(context).pop();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(tr(LocaleTr.moreAccount)),
      ),
      body: SafeArea(
        child: Center(
          child: AdaptiveScrollView(
            child: Column(
              children: [
                AccountItem(
                  icon: Platform.isAndroid
                      ? Icons.person_outline_outlined
                      : CupertinoIcons.person,
                  title: tr(LocaleTr.createAccountUsername),
                  value: user?.displayName ?? '-',
                  onTap: () {
                    bottomSheet(
                      context: context,
                      body: [
                        OutlineFormField(
                          autofocus: true,
                          labelText: tr(LocaleTr.accountNewUsername),
                          onFieldSubmitted: (value) async {
                            await Auth.changeUsername(value);
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                ),
                const Divider(thickness: 0.5),
                AccountItem(
                  icon: Platform.isAndroid
                      ? Icons.mail_outline_outlined
                      : CupertinoIcons.mail,
                  title: tr(LocaleTr.loginEmail),
                  value: user?.email,
                  onTap: () {
                    bottomSheet(
                      context: context,
                      body: [
                        OutlineFormField(
                          autofocus: true,
                          labelText: tr(LocaleTr.accountNewEmail),
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (value) => newEmail = value,
                        ),
                        SizedBox(height: 0.02.sh),
                        OutlineFormField(
                          autofocus: true,
                          labelText: tr(LocaleTr.accountConfirmEmail),
                          textInputAction: TextInputAction.done,
                          onFieldSubmitted: (value) async {
                            if (newEmail == value) {
                              await Auth.changeEmail(newEmail!);
                              Navigator.of(context).pop();
                            }
                          },
                        ),
                      ],
                    );
                  },
                ),
                const Divider(thickness: 0.5),
                AccountItem(
                  icon: Icons.password_outlined,
                  title: tr(LocaleTr.loginPassword),
                  value: '******',
                  onTap: () {
                    bottomSheet(
                      context: context,
                      body: [
                        OutlineFormField(
                          autofocus: true,
                          labelText: tr(LocaleTr.accountNewPassword),
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (value) => newPassword = value,
                        ),
                        SizedBox(height: 0.02.sh),
                        OutlineFormField(
                          autofocus: true,
                          labelText: tr(LocaleTr.accountConfirmPassword),
                          textInputAction: TextInputAction.done,
                          onFieldSubmitted: (value) async {
                            if (newPassword == value) {
                              await Auth.changePassword(newPassword!);
                              Navigator.of(context).pop();
                            }
                          },
                        ),
                      ],
                    );
                  },
                ),
                const Divider(thickness: 0.5),
                ListTile(
                  title: Text(
                    tr(LocaleTr.accountDeleteAccount),
                    style: TextStyle(
                      color: Utils.theme(context).colorScheme.error,
                    ),
                  ),
                  onTap: () async {
                    adaptiveActionBottomSheet(
                      context: context,
                      title: tr(LocaleTr.accountDeleteAccount),
                      message: tr(LocaleTr.accountDeleteAccountMsg),
                      actions: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            RoundButton(
                              title: tr(LocaleTr.yes),
                              onPressed: deleteAccount,
                            ),
                            RoundButton(
                              title: tr(LocaleTr.cancel),
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                          ],
                        ),
                      ],
                      cupertinoActions: [
                        CupertinoActionSheetAction(
                          onPressed: deleteAccount,
                          child: Text(tr(LocaleTr.yes)),
                        ),
                      ],
                    );
                  },
                ),
                SizedBox(height: 0.07.sh),
                RoundButton(
                  title: tr(LocaleTr.accountSignOut),
                  onPressed: () async {
                    await Auth.signOut();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AccountItem extends StatelessWidget {
  const AccountItem({
    Key? key,
    required this.icon,
    required this.title,
    this.value,
    this.onTap,
  }) : super(key: key);

  final IconData? icon;
  final String? title;
  final String? value;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: ListTile(
        leading: Icon(
          icon,
          color: Utils.theme(context).colorScheme.secondary,
        ),
        title: Text(
          title!,
          style: Utils.theme(context).textTheme.bodyText1!.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 16.sp,
              ),
        ),
        trailing: Text(
          value ?? '',
          style: Utils.theme(context).textTheme.bodyText1,
        ),
      ),
    );
  }
}
