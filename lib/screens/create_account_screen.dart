import 'package:caishen_wallet/screens/widgets/outline_form_field_widget.dart';
import 'package:caishen_wallet/screens/widgets/round_button_widget.dart';
import 'package:caishen_wallet/screens/widgets/snackbar_widget.dart';
import 'package:caishen_wallet/services/auth.dart';
import 'package:caishen_wallet/utils/localizations.dart';
import 'package:caishen_wallet/utils/utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({
    Key? key,
  }) : super(key: key);

  static const String routeName = '/create_account_screen';

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late String _email;
  late String _password;
  late String _confirmPassword;
  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    Future<void> _createAccount() async {
      try {
        if (Utils.formIsValid(_formKey)) {
          if (_password == _confirmPassword) {
            await Auth.createAccount(_name, _email, _password);
            Navigator.of(context).pop();
          } else {
            showSnackbar(
              context: context,
              msg: tr(LocaleTr.passwordsMatchError),
              color: Utils.theme(context).errorColor,
            );
          }
        }
      } catch (e) {
        showSnackbar(
          context: context,
          msg: e.toString(),
          color: Utils.theme(context).errorColor,
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(tr(LocaleTr.createAccount)),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 0.15.sw),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    OutlineFormField(
                      initialValue: '',
                      labelText: tr(LocaleTr.createAccountUsername),
                      onSaved: (value) => _name = value,
                    ),
                    SizedBox(height: 0.02.sh),
                    OutlineFormField(
                      initialValue: '',
                      labelText: tr(LocaleTr.loginEmail),
                      onSaved: (value) => _email = value,
                    ),
                    SizedBox(height: 0.02.sh),
                    OutlineFormField(
                      obscureText: !_showPassword,
                      labelText: tr(LocaleTr.loginPassword),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _showPassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () =>
                            setState(() => _showPassword = !_showPassword),
                      ),
                      onSaved: (value) => _password = value,
                    ),
                    SizedBox(height: 0.02.sh),
                    OutlineFormField(
                      obscureText: !_showPassword,
                      labelText: tr(LocaleTr.createAccountConfirmPassword),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _showPassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () =>
                            setState(() => _showPassword = !_showPassword),
                      ),
                      onSaved: (value) => _confirmPassword = value,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 0.02.sh),
            RoundButton(
              title: tr(LocaleTr.createAccount),
              onPressed: _createAccount,
            ),
          ],
        ),
      ),
    );
  }
}
