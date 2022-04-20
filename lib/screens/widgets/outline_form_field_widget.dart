import 'package:caishen_wallet/utils/localizations.dart';
import 'package:caishen_wallet/utils/utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OutlineFormField extends StatelessWidget {
  const OutlineFormField({
    Key? key,
    this.readOnly,
    this.labelText,
    this.autofocus,
    this.decoration,
    this.onSaved,
    this.onFieldSubmitted,
    this.initialValue,
    this.obscureText,
    this.textInputAction,
    this.textCapitalization,
    this.suffixIcon,
  }) : super(key: key);

  final bool? readOnly;
  final String? labelText;
  final bool? autofocus;
  final InputDecoration? decoration;
  final ValueChanged<String>? onSaved;
  final ValueChanged<String>? onFieldSubmitted;
  final String? initialValue;
  final bool? obscureText;
  final TextInputAction? textInputAction;
  final TextCapitalization? textCapitalization;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    final _borderRadius = BorderRadius.all(Radius.circular(30.r));

    return TextFormField(
      readOnly: readOnly ?? false,
      initialValue: initialValue,
      autofocus: autofocus ?? false,
      onSaved: (value) => onSaved!(value!),
      onFieldSubmitted: (value) => onFieldSubmitted!(value),
      obscureText: obscureText ?? false,
      textInputAction: textInputAction,
      textCapitalization: textCapitalization ?? TextCapitalization.none,
      decoration: decoration ??
          InputDecoration(
            labelText: labelText,
            labelStyle: Utils.theme(context).textTheme.bodyText1,
            filled: true,
            fillColor: Colors.transparent,
            suffixIcon: suffixIcon,
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
                color: Utils.theme(context).errorColor,
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
