import 'package:caishen_wallet/services/auth.dart';
import 'package:caishen_wallet/ui/widgets/round_button_widget.dart';
import 'package:caishen_wallet/utils/localizations.dart';
import 'package:caishen_wallet/utils/utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    Key? key,
  }) : super(key: key);

  static const String routeName = '/profile_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          tr(LocaleTr.moreProfile),
          style: Utils.theme(context).textTheme.headline2,
        ),
      ),
      body: SafeArea(
        child: Center(
          child: RoundButton(
            title: tr(LocaleTr.profileSignOut),
            onPressed: () {
              Auth.signOut();
              Navigator.of(context).pop();
            },
          ),
        ),
      ),
    );
  }
}
