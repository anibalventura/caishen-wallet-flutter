import 'dart:io';

import 'package:caishen_wallet/data/controllers/transaction_controller.dart';
import 'package:caishen_wallet/ui/widgets/adaptive_date_picker.dart';
import 'package:caishen_wallet/ui/widgets/bottom_sheet_widget.dart';
import 'package:caishen_wallet/ui/widgets/outline_form_field_widget.dart';
import 'package:caishen_wallet/ui/widgets/snackbar_widget.dart';
import 'package:caishen_wallet/ui/widgets/transaction_field_widget.dart';
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
    final _transactionController =
        Provider.of<TransactionController>(context, listen: false);

    Future<void> _addTransaction() async {
      if (_transactionController.amount != 0 &&
          _transactionController.description.isNotEmpty) {
        await _transactionController.add();

        Navigator.of(context).pop();
      } else {
        showSnackbar(
          context: context,
          msg: tr(LocaleTr.completeFieldError),
          color: Utils.theme(context).errorColor,
        );
      }
    }

    void _selectPayment(TransactionController transactionController) {
      final payment = [
        tr(LocaleTr.paymentCash),
        tr(LocaleTr.paymentCreditCard),
        tr(LocaleTr.paymentDebitCard),
        tr(LocaleTr.paymentBankTransfer),
        tr(LocaleTr.paymentOther),
      ];

      bottomSheet(
        context: context,
        body: [
          ListView.builder(
            itemCount: payment.length,
            shrinkWrap: true,
            itemBuilder: (_, index) {
              return ListTile(
                title: Text(payment[index]),
                onTap: () {
                  transactionController.payment = payment[index];
                  Navigator.of(context).pop();
                },
              );
            },
          )
        ],
      );
    }

    void _selectCategory(TransactionController transactionController) {
      final category = [
        tr(LocaleTr.categoryFoodDrinks),
        tr(LocaleTr.categoryShopping),
        tr(LocaleTr.categoryTransport),
        tr(LocaleTr.categoryHealthFitness),
        tr(LocaleTr.categoryPersonalCare),
        tr(LocaleTr.categoryHouse),
        tr(LocaleTr.categoryInvestment),
        tr(LocaleTr.categoryVehicle),
        tr(LocaleTr.categoryEducation),
        tr(LocaleTr.categoryOther),
      ];

      bottomSheet(
        context: context,
        body: [
          ListView.builder(
            itemCount: category.length,
            shrinkWrap: true,
            itemBuilder: (_, index) {
              return ListTile(
                title: Text(category[index]),
                onTap: () {
                  transactionController.category = category[index];
                  Navigator.of(context).pop();
                },
              );
            },
          )
        ],
      );
    }

    void _selectDateAndTime(TransactionController transactionController) {
      adaptiveDatePicker(
        context: context,
        minimumDate: DateTime(1),
        maximumDate: DateTime(3000),
        mode: CupertinoDatePickerMode.dateAndTime,
        onDateSelected: (picked) {
          transactionController.dateAndTime = picked;
        },
      );
    }

    void _enterDescription(TransactionController transactionController) {
      bottomSheet(
        context: context,
        padding: EdgeInsets.symmetric(horizontal: 0.05.sw),
        body: [
          OutlineFormField(
            initialValue: transactionController.description,
            autofocus: true,
            onFieldSubmitted: (value) {
              transactionController.description = value;
              Navigator.of(context).pop();
            },
          ),
        ],
      );
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
            onPressed: _addTransaction,
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
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
                          groupValue: transaction.type,
                          borderColor: Colors.blueGrey,
                          pressedColor: Colors.blueGrey,
                          selectedColor: Colors.blueGrey,
                          onValueChanged: (int value) =>
                              transaction.type = value,
                        ),
                        TextFormField(
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          style: Utils.theme(context)
                              .textTheme
                              .headline1!
                              .copyWith(
                                fontSize: 40.sp,
                                color: transaction.type == 0
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
                          onChanged: (value) =>
                              transaction.amount = double.parse(value),
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
                            title: tr(LocaleTr.transactionPayment),
                            trailingValue: transaction.payment,
                            onTap: () => _selectPayment(transaction),
                          ),
                          TransactionField(
                            icon: Icons.category_outlined,
                            title: tr(LocaleTr.transactionCategory),
                            trailingValue: transaction.category,
                            onTap: () => _selectCategory(transaction),
                          ),
                          TransactionField(
                            icon: Platform.isAndroid
                                ? Icons.date_range_outlined
                                : CupertinoIcons.calendar_today,
                            title: tr(LocaleTr.transactionDateTime),
                            trailingValue: Utils.formatDateAndTime(
                              transaction.dateAndTime,
                            ),
                            showTrailingIcon: false,
                            onTap: () => _selectDateAndTime(transaction),
                          ),
                          TransactionField(
                            icon: Platform.isAndroid
                                ? Icons.edit_note_outlined
                                : CupertinoIcons.pencil_ellipsis_rectangle,
                            title: tr(LocaleTr.transactionDescription),
                            trailingValue: transaction.description,
                            showTrailingIcon: false,
                            onTap: () => _enterDescription(transaction),
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
