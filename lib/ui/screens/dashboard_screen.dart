import 'package:caishen_wallet/utils/utils.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  static const String routeName = '/dashboard_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Text(
            'Dashboard Screen',
            style: Utils.theme(context).textTheme.bodyText1,
          ),
        ),
      ),
    );
  }
}
