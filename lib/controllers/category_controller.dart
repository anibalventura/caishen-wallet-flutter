import 'package:caishen_wallet/utils/localizations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CategoryController extends ChangeNotifier {
  final List<String> _categories = [
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
  List<String> get items => _categories;
}
