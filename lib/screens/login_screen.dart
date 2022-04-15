import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:caishen_wallet/controllers/category_controller.dart';
import 'package:caishen_wallet/controllers/payment_type_controller.dart';
import 'package:caishen_wallet/screens/widgets/outline_form_field_widget.dart';
import 'package:caishen_wallet/screens/widgets/round_button_widget.dart';
import 'package:caishen_wallet/screens/widgets/snackbar_widget.dart';
import 'package:caishen_wallet/services/auth.dart';
import 'package:caishen_wallet/utils/localizations.dart';
import 'package:caishen_wallet/utils/utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    late String _email;
    late String _password;

    Future<void> _logIn() async {
      if (Utils.formIsValid(_formKey)) {
        final retVal = await Auth.signIn(_email, _password);

        if (retVal != 'Success') {
          showSnackbar(
            context: context,
            msg: retVal,
            color: Utils.theme(context).errorColor,
          );
        }
      }
    }

    Future<void> _createAccount() async {
      if (Utils.formIsValid(_formKey)) {
        final retVal = await Auth.createAccount(_email, _password);

        if (retVal != 'Success') {
          showSnackbar(
            context: context,
            msg: retVal,
            color: Utils.theme(context).errorColor,
          );
        } else {
          final categoryController = CategoryController();
          final paymentTypeController = PaymentTypeController();

          await categoryController.newUser();
          await paymentTypeController.newUser();
        }
      }
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextLiquidFill(
              text: LocaleTr.appName,
              boxHeight: 0.15.sh,
              waveColor: Utils.theme(context).colorScheme.primary,
              boxBackgroundColor: Utils.theme(context).colorScheme.background,
              textStyle: TextStyle(
                fontSize: 50.sp,
                fontFamily: GoogleFonts.sansitaSwashed().fontFamily,
              ),
            ),
            SizedBox(height: 0.01.sh),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 0.15.sw),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    OutlineFormField(
                      // TODO(anibal): Save last email.
                      initialValue: '',
                      labelText: tr(LocaleTr.loginEmail),
                      onSaved: (value) => _email = value,
                    ),
                    SizedBox(height: 0.02.sh),
                    OutlineFormField(
                      obscureText: true,
                      labelText: tr(LocaleTr.loginPassword),
                      onSaved: (value) => _password = value,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 0.02.sh),
            RoundButton(
              title: tr(LocaleTr.loginSignIn),
              onPressed: _logIn,
            ),
            SizedBox(height: 0.05.sh),
            TextButton(
              onPressed: _createAccount,
              child: Text(
                tr(LocaleTr.loginNoAccount),
                style: Utils.theme(context).textTheme.bodyText1!.copyWith(
                      color: Utils.theme(context).colorScheme.secondary,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
