import 'package:caishen_wallet/utils/utils.dart';
import 'package:flutter/material.dart';

class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({Key? key}) : super(key: key);

  static const String routeName = '/transactions_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Text(
            'Transactions Screen',
            style: Utils.theme(context).textTheme.bodyText1,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Utils.theme(context).colorScheme.secondary,
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () {},
      ),
    );
  }
}
