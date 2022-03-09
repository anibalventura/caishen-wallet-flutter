import 'package:caishen_wallet/utils/localizations.dart';
import 'package:caishen_wallet/utils/utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OutlineFormField extends StatelessWidget {
  const OutlineFormField({
    Key? key,
    required this.labelText,
    required this.onSaved,
    this.initialValue,
    this.obscureText,
  }) : super(key: key);

  final String labelText;
  final ValueChanged<String> onSaved;
  final String? initialValue;
  final bool? obscureText;

  @override
  Widget build(BuildContext context) {
    final _borderRadius = BorderRadius.all(Radius.circular(30.r));

    return TextFormField(
      initialValue: initialValue,
      onSaved: (value) => onSaved(value!),
      obscureText: obscureText ?? false,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: Utils.theme(context).textTheme.bodyText1,
        filled: true,
        fillColor: Colors.transparent,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 0.05.sw,
          vertical: 0.015.sh,
        ),
        border: OutlineInputBorder(
          borderRadius: _borderRadius,
          borderSide: BorderSide(
            color: Utils.theme(context).colorScheme.primary,
            width: 1.2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: _borderRadius,
          borderSide: BorderSide(
            color: Utils.theme(context).colorScheme.secondary,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: _borderRadius,
          borderSide: BorderSide(
            color: Utils.theme(context).colorScheme.onError,
          ),
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return tr(LocaleTr.emptyFormFieldError);
        }
        return null;
      },
    );
  }
}
