import 'package:caishen_wallet/utils/utils.dart';
import 'package:flutter/material.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({
    Key? key,
  }) : super(key: key);

  static const String routeName = '/more_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Text(
            'More Screen',
            style: Utils.theme(context).textTheme.bodyText1,
          ),
        ),
      ),
    );
  }
}
