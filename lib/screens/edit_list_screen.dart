import 'dart:io';
import 'package:caishen_wallet/controllers/category_controller.dart';
import 'package:caishen_wallet/controllers/payment_type_controller.dart';
import 'package:caishen_wallet/models/category_model.dart';
import 'package:caishen_wallet/models/payment_type_model.dart';
import 'package:caishen_wallet/screens/settings_screen.dart';
import 'package:caishen_wallet/screens/widgets/adaptive_scroll_view.dart';
import 'package:caishen_wallet/screens/widgets/bottom_sheet_widget.dart';
import 'package:caishen_wallet/screens/widgets/liquid_progress_indicator_widget.dart';
import 'package:caishen_wallet/screens/widgets/outline_form_field_widget.dart';
import 'package:caishen_wallet/screens/widgets/snackbar_widget.dart';
import 'package:caishen_wallet/screens/widgets/swipe_item_widget.dart';
import 'package:caishen_wallet/utils/localizations.dart';
import 'package:caishen_wallet/utils/utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditListScreen extends StatelessWidget {
  EditListScreen({
    Key? key,
  }) : super(key: key);

  static const String routeName = '/edit_list_screen';

  final formKey = GlobalKey<FormState>();
  final CategoryController _categoryController = CategoryController();
  final PaymentTypeController _paymentTypeController = PaymentTypeController();

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments;

    void addItem() {
      bottomSheet(
        context: context,
        padding: EdgeInsets.symmetric(horizontal: 0.05.sw),
        body: [
          Form(
            key: formKey,
            child: OutlineFormField(
              initialValue: '',
              autofocus: true,
              textCapitalization: TextCapitalization.words,
              onFieldSubmitted: (value) {
                if (args == SettingsEnum.categories) {
                  _categoryController.add(value);
                } else {
                  _paymentTypeController.add(value);
                }
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      );
    }

    void editItem(String id, String name) {
      bottomSheet(
        context: context,
        padding: EdgeInsets.symmetric(horizontal: 0.05.sw),
        body: [
          Form(
            key: formKey,
            child: OutlineFormField(
              initialValue: name,
              autofocus: true,
              textCapitalization: TextCapitalization.words,
              onFieldSubmitted: (value) {
                if (args == SettingsEnum.categories) {
                  _categoryController
                      .update(CategoryModel(id: id, name: value));
                } else {
                  _paymentTypeController
                      .update(PaymentTypeModel(id: id, name: value));
                }
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      );
    }

    void deleteItem(String id) {
      if (args == SettingsEnum.categories) {
        _categoryController.delete(docId: id);
      } else {
        _paymentTypeController.delete(docId: id);
      }

      showSnackbar(
        context: context,
        msg: args == SettingsEnum.categories
            ? tr(LocaleTr.settingsCategoriesEditSnackbar)
            : tr(LocaleTr.settingsPaymentTypesEditSnackbar),
        color: Utils.theme(context).colorScheme.primary,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          args == SettingsEnum.categories
              ? tr(LocaleTr.settingsCategories)
              : tr(LocaleTr.settingsPaymentTypes),
        ),
        actions: [
          if (Platform.isIOS)
            TextButton(
              onPressed: addItem,
              child: Text(
                tr(LocaleTr.transactionAdd),
                style: Utils.theme(context).textTheme.bodyText1!.copyWith(
                      color: Colors.white,
                    ),
              ),
            ),
        ],
      ),
      body: SafeArea(
        child: args == SettingsEnum.categories
            ? StreamBuilder(
                stream: _categoryController.categories(),
                builder: (
                  BuildContext context,
                  AsyncSnapshot<List<CategoryModel>> snapshot,
                ) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    return AdaptiveScrollView(
                      child: ListView.separated(
                        itemCount: snapshot.data!.length,
                        separatorBuilder: (context, index) {
                          return const Divider();
                        },
                        itemBuilder: (_, index) {
                          final item = snapshot.data![index];

                          return SwipeItem(
                            itemKey: item.id!,
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
                            swipeLeftAction: () => deleteItem(item.id!),
                            swipeRightColor:
                                Utils.theme(context).highlightColor,
                            swipeRightIcon: Platform.isAndroid
                                ? const Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                  )
                                : const Icon(
                                    CupertinoIcons.pencil,
                                    color: Colors.white,
                                  ),
                            swipeRightAction: () =>
                                editItem(item.id!, item.name!),
                            child: ListTile(
                              title: Text(item.name!),
                            ),
                          );
                        },
                      ),
                    );
                  } else {
                    return const Scaffold(
                      body: LiquidProgressIndicator(),
                    );
                  }
                },
              )
            : StreamBuilder(
                stream: _paymentTypeController.paymentTypes(),
                builder: (
                  BuildContext context,
                  AsyncSnapshot<List<PaymentTypeModel>> snapshot,
                ) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    return AdaptiveScrollView(
                      child: ListView.separated(
                        itemCount: snapshot.data!.length,
                        separatorBuilder: (context, index) {
                          return const Divider();
                        },
                        itemBuilder: (_, index) {
                          final item = snapshot.data![index];

                          return SwipeItem(
                            itemKey: item.id!,
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
                            swipeLeftAction: () => deleteItem(item.id!),
                            swipeRightColor:
                                Utils.theme(context).highlightColor,
                            swipeRightIcon: Platform.isAndroid
                                ? const Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                  )
                                : const Icon(
                                    CupertinoIcons.pencil,
                                    color: Colors.white,
                                  ),
                            swipeRightAction: () =>
                                editItem(item.id!, item.name!),
                            child: ListTile(
                              title: Text(item.name!),
                            ),
                          );
                        },
                      ),
                    );
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
              onPressed: addItem,
              tooltip: tr(LocaleTr.transactionAdd),
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            )
          : null,
    );
  }
}
