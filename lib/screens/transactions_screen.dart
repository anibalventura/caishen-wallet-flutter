import 'dart:io';
import 'package:caishen_wallet/controllers/transaction_controller.dart';
import 'package:caishen_wallet/models/transaction_model.dart';
import 'package:caishen_wallet/screens/add_transaction_screen.dart';
import 'package:caishen_wallet/screens/widgets/adaptive_action_bottom_sheet_widget.dart';
import 'package:caishen_wallet/screens/widgets/adaptive_scroll_view.dart';
import 'package:caishen_wallet/screens/widgets/liquid_progress_indicator_widget.dart';
import 'package:caishen_wallet/screens/widgets/round_button_widget.dart';
import 'package:caishen_wallet/screens/widgets/snackbar_widget.dart';
import 'package:caishen_wallet/screens/widgets/swipe_item_widget.dart';
import 'package:caishen_wallet/screens/widgets/transaction_item_widget.dart';
import 'package:caishen_wallet/utils/localizations.dart';
import 'package:caishen_wallet/utils/utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TransactionsScreen extends StatelessWidget {
  TransactionsScreen({
    Key? key,
  }) : super(key: key);

  static const String routeName = '/transactions_screen';

  final TransactionController _transactionController = TransactionController();

  @override
  Widget build(BuildContext context) {
    void _deleteTransaction(String id) {
      _transactionController.delete(docId: id);
      showSnackbar(
        context: context,
        msg: tr(LocaleTr.transactionDeleteSnackbar),
        color: Utils.theme(context).colorScheme.primary,
      );
      Navigator.of(context).pop();
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Utils.theme(context).scaffoldBackgroundColor,
        elevation: 0,
        actions: [
          if (Platform.isIOS)
            TextButton(
              child: Text(
                tr(LocaleTr.transactionAdd),
                style: Utils.theme(context).textTheme.bodyText1!.copyWith(
                      color: Utils.theme(context).primaryColor,
                    ),
              ),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  AddTransactionScreen.routeName,
                );
              },
            ),
        ],
      ),
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
                return AdaptiveScrollView(
                  child: ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (_, index) {
                      return SwipeItem(
                        itemKey: snapshot.data![index].id!,
                        swipeLeftColor: Utils.theme(context).errorColor,
                        swipeLeftIcon: Platform.isAndroid
                            ? const Icon(
                                Icons.delete,
                                color: Colors.white,
                              )
                            : const Icon(
                                CupertinoIcons.delete,
                                color: Colors.white,
                              ),
                        swipeLeftAction: () {
                          final transactionId = snapshot.data![index].id!;

                          adaptiveActionBottomSheet(
                            context: context,
                            title: tr(LocaleTr.transactionDeleteTitle),
                            message: tr(LocaleTr.transactionDeleteMsg),
                            actions: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  RoundButton(
                                    title: tr(LocaleTr.yes),
                                    onPressed: () =>
                                        _deleteTransaction(transactionId),
                                  ),
                                  RoundButton(
                                    title: tr(LocaleTr.cancel),
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                  ),
                                ],
                              ),
                            ],
                            cupertinoActions: [
                              CupertinoActionSheetAction(
                                onPressed: () =>
                                    _deleteTransaction(transactionId),
                                child: Text(tr(LocaleTr.yes)),
                              ),
                            ],
                          );
                        },
                        child: TransactionItem(
                          transaction: snapshot.data![index],
                          onTap: () => Navigator.pushNamed(
                            context,
                            AddTransactionScreen.routeName,
                            arguments: snapshot.data![index],
                          ),
                        ),
                      );
                    },
                  ),
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
      floatingActionButton: Platform.isAndroid
          ? FloatingActionButton(
              backgroundColor: Utils.theme(context).colorScheme.secondary,
              tooltip: tr(LocaleTr.transactionAdd),
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
              onPressed: () => Navigator.of(context)
                  .pushNamed(AddTransactionScreen.routeName),
            )
          : null,
    );
  }
}
