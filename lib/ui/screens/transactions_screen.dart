import 'package:caishen_wallet/data/controllers/transaction_controller.dart';
import 'package:caishen_wallet/data/models/transaction_model.dart';
import 'package:caishen_wallet/ui/screens/add_transaction_screen.dart';
import 'package:caishen_wallet/ui/widgets/liquid_progress_indicator_widget.dart';
import 'package:caishen_wallet/ui/widgets/transaction_item_widget.dart';
import 'package:caishen_wallet/utils/localizations.dart';
import 'package:caishen_wallet/utils/utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class TransactionsScreen extends StatelessWidget {
  TransactionsScreen({Key? key}) : super(key: key);

  static const String routeName = '/transactions_screen';

  final TransactionController _transactionController = TransactionController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder(
          stream: _transactionController.transactions(),
          builder: (
            BuildContext context,
            AsyncSnapshot<List<TransactionModel>> snapshot,
          ) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.data!.isEmpty) {
                return Center(
                  child: Text(
                    tr(LocaleTr.dontHaveTransactions),
                    style: Utils.theme(context).textTheme.headline1,
                  ),
                );
              } else {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (_, index) {
                    return TransactionItem(
                      transaction: snapshot.data![index],
                    );
                  },
                );
              }
            } else {
              return const Scaffold(
                body: LiquidProgressIndicator(),
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Utils.theme(context).colorScheme.secondary,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () =>
            Navigator.of(context).pushNamed(AddTransactionScreen.routeName),
      ),
    );
  }
}
