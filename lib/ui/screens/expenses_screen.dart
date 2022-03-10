import 'package:caishen_wallet/utils/utils.dart';
import 'package:flutter/material.dart';

class ExpensesScreen extends StatelessWidget {
  const ExpensesScreen({Key? key}) : super(key: key);

  static const String routeName = '/expenses_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Text(
            'Expenses Screen',
            style: Utils.theme(context).textTheme.bodyText1,
          ),
        ),
      ),
    );
  }
}
