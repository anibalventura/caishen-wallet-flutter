import 'package:caishen_wallet/ui/themes.dart';
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
    this.onFieldSubmitted,
    this.initialValue,
    this.obscureText,
  }) : super(key: key);

  final String labelText;
  final ValueChanged<String> onSaved;
  final Function? onFieldSubmitted;
  final String? initialValue;
  final bool? obscureText;

  @override
  Widget build(BuildContext context) {
    final _borderRadius = BorderRadius.all(Radius.circular(30.r));

    return TextFormField(
      initialValue: initialValue,
      obscureText: obscureText ?? false,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: Utils.theme(context).textTheme.bodyText1!.copyWith(
              fontSize: Themes().bodyTextSize,
            ),
        filled: true,
        fillColor: Colors.transparent,
        contentPadding: EdgeInsets.symmetric(
          horizontal: Utils.isLandscape() ? 0.02.sw : 0.05.sw,
          vertical: Utils.isLandscape() ? 0.05.sh : 0.015.sh,
        ),
        border: OutlineInputBorder(
          borderRadius: _borderRadius,
          borderSide: BorderSide(
            color: Utils.theme(context).primaryColor,
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
      onSaved: (value) => onSaved(value!),
      onFieldSubmitted: (_) => onFieldSubmitted,
    );
  }
}
