import 'package:caishen_wallet/data/models/transaction_model.dart';
import 'package:caishen_wallet/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    Key? key,
    required this.transaction,
  }) : super(key: key);

  final TransactionModel transaction;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 0.05.sw,
        vertical: 0.01.sh,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 0.05.sw,
        vertical: 0.02.sh,
      ),
      decoration: BoxDecoration(
        color: Colors.blueGrey.shade50,
        borderRadius: BorderRadius.all(Radius.circular(20.r)),
      ),
      child: InkWell(
        onTap: () {},
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
                  style: Utils.theme(context).textTheme.headline2!.copyWith(
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
