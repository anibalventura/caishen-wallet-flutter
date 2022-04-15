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
import 'package:caishen_wallet/utils/localizations.dart';
import 'package:caishen_wallet/utils/utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({
    Key? key,
  }) : super(key: key);

  static const String routeName = '/transactions_screen';

  @override
  Widget build(BuildContext context) {
    final transactionController =
        Provider.of<TransactionController>(context, listen: false);

    void _deleteTransaction(String id) {
      transactionController.delete(docId: id);
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
              onPressed: () => Navigator.pushNamed(
                context,
                AddTransactionScreen.routeName,
              ),
            ),
        ],
      ),
      body: SafeArea(
        child: StreamBuilder(
          stream: transactionController.transactions(),
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
                  child: ListView.separated(
                    itemCount: snapshot.data!.length,
                    separatorBuilder: (context, index) {
                      return const Divider(
                        thickness: 1,
                      );
                    },
                    itemBuilder: (_, index) {
                      return SwipeItem(
                        itemKey: snapshot.data![index].id!,
                        dismissDirection: DismissDirection.endToStart,
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

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    Key? key,
    required this.transaction,
    required this.onTap,
  }) : super(key: key);

  final TransactionModel transaction;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 0.05.sw,
        vertical: 0.01.sh,
      ),
      child: InkWell(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.category!,
                  style: Utils.theme(context).textTheme.headline1,
                ),
                SizedBox(height: 0.005.sh),
                Text(
                  transaction.description!,
                  style: Utils.theme(context).textTheme.bodyText1,
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  Utils.formatToMoney(transaction.amount!),
                  style: Utils.theme(context).textTheme.headline1!.copyWith(
                        color: transaction.type == 0
                            ? Utils.theme(context).errorColor
                            : Utils.theme(context).colorScheme.primary,
                      ),
                ),
                SizedBox(height: 0.005.sh),
                Text(
                  Utils.formatDateAndTimeFromMill(transaction.dateAndTime!),
                  style: Utils.theme(context).textTheme.bodyText1,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
