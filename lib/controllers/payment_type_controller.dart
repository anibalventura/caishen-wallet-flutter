import 'package:caishen_wallet/utils/localizations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class PaymentTypeController extends ChangeNotifier {
  final List<String> _paymentTypes = [
    tr(LocaleTr.paymentCash),
    tr(LocaleTr.paymentCreditCard),
    tr(LocaleTr.paymentDebitCard),
    tr(LocaleTr.paymentBankTransfer),
    tr(LocaleTr.paymentOther),
  ];
  List<String> get items => _paymentTypes;
}
