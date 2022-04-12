import 'dart:io';
import 'package:caishen_wallet/controllers/category_controller.dart';
import 'package:caishen_wallet/controllers/payment_type_controller.dart';
import 'package:caishen_wallet/controllers/transaction_controller.dart';
import 'package:caishen_wallet/models/transaction_model.dart';
import 'package:caishen_wallet/screens/widgets/adaptive_date_picker.dart';
import 'package:caishen_wallet/screens/widgets/bottom_sheet_widget.dart';
import 'package:caishen_wallet/screens/widgets/outline_form_field_widget.dart';
import 'package:caishen_wallet/screens/widgets/snackbar_widget.dart';
import 'package:caishen_wallet/screens/widgets/transaction_field_widget.dart';
import 'package:caishen_wallet/services/auth.dart';
import 'package:caishen_wallet/utils/localizations.dart';
import 'package:caishen_wallet/utils/utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class AddTransactionScreen extends StatelessWidget {
  AddTransactionScreen({
    Key? key,
  }) : super(key: key);

  static const String routeName = '/add_transaction_screen';

  final Map<int, Widget> _transactionTypes = {
    0: Text(tr(LocaleTr.transactionExpense)),
    1: Text(tr(LocaleTr.transactionIncome)),
  };

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as TransactionModel?;
    final transactionController = Provider.of<TransactionController>(
      context,
      listen: false,
    );

    Future<void> _addTransaction(TransactionModel? transaction) async {
      if (transactionController.amount != 0 ||
          args?.amount != 0 && transactionController.description.isNotEmpty) {
        if (args != null) {
          await transactionController.update(
            uid: Auth.auth.currentUser!.uid,
            transaction: transaction!,
          );
        } else {
          await transactionController.add();
        }

        Navigator.of(context).pop();
      } else {
        showSnackbar(
          context: context,
          msg: tr(LocaleTr.completeFieldError),
          color: Utils.theme(context).errorColor,
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade50,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Platform.isAndroid
                ? Icons.cancel_outlined
                : CupertinoIcons.clear_circled,
          ),
          color: Utils.theme(context).errorColor,
          tooltip: tr(LocaleTr.cancel),
          onPressed: Navigator.of(context).pop,
        ),
        actions: [
          IconButton(
            icon: Icon(
              Platform.isAndroid
                  ? Icons.save_outlined
                  : CupertinoIcons.floppy_disk,
            ),
            color: Utils.theme(context).iconTheme.color,
            tooltip: tr(LocaleTr.save),
            onPressed: () => _addTransaction(
              TransactionModel(
                id: args?.id,
                type: args?.type,
                amount: args?.amount,
                paymentType: args?.paymentType,
                category: args?.category,
                dateAndTime: args?.dateAndTime,
                description: args?.description,
              ),
            ),
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SafeArea(
          child: Consumer<TransactionController>(
            builder: (context, transaction, _) {
              return Container(
                padding: EdgeInsets.only(
                  top: 0.02.sh,
                ),
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        CupertinoSegmentedControl(
                          children: _transactionTypes,
                          groupValue: args?.type ?? transaction.type,
                          borderColor: Colors.blueGrey,
                          pressedColor: Colors.blueGrey,
                          selectedColor: Colors.blueGrey,
                          onValueChanged: (int value) {
                            transaction.type = value;
                            args?.type = value;
                          },
                        ),
                        TextFormField(
                          initialValue: args?.amount.toString(),
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          style: Utils.theme(context)
                              .textTheme
                              .headline1!
                              .copyWith(
                                fontSize: 40.sp,
                                color: args?.type == 0
                                    ? Utils.theme(context).errorColor
                                    : Utils.theme(context).colorScheme.primary,
                              ),
                          textAlign: TextAlign.right,
                          decoration: InputDecoration(
                            hintText: '0.00',
                            prefixIcon: Icon(
                              Platform.isAndroid
                                  ? Icons.attach_money_rounded
                                  : CupertinoIcons.money_dollar,
                              size: 40.sp,
                              color: Colors.green,
                            ),
                            prefixIconConstraints: BoxConstraints(
                              minWidth: 0.2.sw,
                            ),
                            hintStyle: TextStyle(
                              color: transaction.type == 0
                                  ? Utils.theme(context).errorColor
                                  : Utils.theme(context).colorScheme.primary,
                            ),
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.zero,
                              borderSide: BorderSide.none,
                            ),
                          ),
                          onChanged: (value) {
                            transaction.amount = double.parse(value);
                            args?.amount = double.parse(value);
                          },
                        ),
                      ],
                    ),
                    Expanded(
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          TransactionField(
                            icon: Platform.isAndroid
                                ? Icons.payment_outlined
                                : CupertinoIcons.creditcard,
                            title: tr(LocaleTr.transactionPaymentType),
                            trailingValue:
                                args?.paymentType ?? transaction.paymentType,
                            onTap: () => bottomSheet(
                              context: context,
                              body: [
                                Consumer<PaymentTypeController>(
                                  builder: (context, paymentType, _) {
                                    final paymentTypes = paymentType.items;

                                    return ListView.builder(
                                      itemCount: paymentTypes.length,
                                      shrinkWrap: true,
                                      itemBuilder: (_, index) {
                                        return ListTile(
                                          title: Text(paymentTypes[index]),
                                          onTap: () {
                                            transactionController.paymentType =
                                                paymentTypes[index];
                                            args?.paymentType =
                                                paymentTypes[index];
                                            Navigator.of(context).pop();
                                          },
                                        );
                                      },
                                    );
                                  },
                                )
                              ],
                            ),
                          ),
                          TransactionField(
                            icon: Icons.category_outlined,
                            title: tr(LocaleTr.transactionCategory),
                            trailingValue:
                                args?.category ?? transaction.category,
                            onTap: () => bottomSheet(
                              context: context,
                              body: [
                                Consumer<CategoryController>(
                                  builder: (context, category, _) {
                                    final categories = category.items;

                                    return ListView.builder(
                                      itemCount: categories.length,
                                      shrinkWrap: true,
                                      itemBuilder: (_, index) {
                                        return ListTile(
                                          title: Text(categories[index]),
                                          onTap: () {
                                            transactionController.category =
                                                categories[index];
                                            args?.category = categories[index];
                                            Navigator.of(context).pop();
                                          },
                                        );
                                      },
                                    );
                                  },
                                )
                              ],
                            ),
                          ),
                          TransactionField(
                            icon: Platform.isAndroid
                                ? Icons.date_range_outlined
                                : CupertinoIcons.calendar_today,
                            title: tr(LocaleTr.transactionDateTime),
                            trailingValue: Utils.formatDateAndTime(
                              DateTime.fromMillisecondsSinceEpoch(
                                args?.dateAndTime ??
                                    transaction
                                        .dateAndTime.millisecondsSinceEpoch,
                              ),
                            ),
                            showTrailingIcon: false,
                            onTap: () => adaptiveDatePicker(
                              context: context,
                              minimumDate: DateTime(1),
                              maximumDate: DateTime(3000),
                              mode: CupertinoDatePickerMode.dateAndTime,
                              onDateSelected: (picked) {
                                transactionController.dateAndTime = picked;
                                args?.dateAndTime =
                                    picked.millisecondsSinceEpoch;
                              },
                            ),
                          ),
                          TransactionField(
                            icon: Platform.isAndroid
                                ? Icons.edit_note_outlined
                                : CupertinoIcons.pencil_ellipsis_rectangle,
                            title: tr(LocaleTr.transactionDescription),
                            trailingValue:
                                args?.description ?? transaction.description,
                            showTrailingIcon: false,
                            onTap: () => bottomSheet(
                              context: context,
                              padding:
                                  EdgeInsets.symmetric(horizontal: 0.05.sw),
                              body: [
                                OutlineFormField(
                                  initialValue: args?.description ??
                                      transaction.description,
                                  autofocus: true,
                                  onFieldSubmitted: (value) {
                                    transactionController.description = value;
                                    args?.description = value;
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
