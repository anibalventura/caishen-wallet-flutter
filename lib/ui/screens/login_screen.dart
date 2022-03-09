import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:caishen_wallet/services/auth.dart';
import 'package:caishen_wallet/ui/screens/home_screen.dart';
import 'package:caishen_wallet/ui/widgets/outline_form_field_widget.dart';
import 'package:caishen_wallet/ui/widgets/round_button_widget.dart';
import 'package:caishen_wallet/ui/widgets/snackbar_widget.dart';
import 'package:caishen_wallet/utils/localizations.dart';
import 'package:caishen_wallet/utils/utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  static const String routeName = '/login_screen';

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    late String _email;
    late String _password;

    Future<void> _logIn() async {
      if (Utils.validateForm(_formKey)) {
        final retVal = await Auth.signIn(_email, _password);

        if (retVal == 'Success') {
          // ignore: unawaited_futures, use_build_context_synchronously
          Navigator.pushReplacementNamed(context, HomeScreen.routeName);
        } else {
          showSnackbar(context: context, msg: retVal);
        }
      }
    }

    Future<void> _createAccount() async {
      if (Utils.validateForm(_formKey)) {
        final retVal = await Auth.createAccount(_email, _password);

        if (retVal == 'Success') {
          // ignore: unawaited_futures, use_build_context_synchronously
          Navigator.pushReplacementNamed(context, HomeScreen.routeName);
        } else {
          showSnackbar(context: context, msg: retVal);
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
              boxBackgroundColor: Colors.white,
              textStyle: TextStyle(
                fontSize: 50.sp,
                fontWeight: FontWeight.bold,
                fontFamily: GoogleFonts.sansitaSwashed().fontFamily,
              ),
            ),
            SizedBox(height: 0.01.sh),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 0.1.sw),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    OutlineFormField(
                      initialValue: '',
                      labelText: tr(LocaleTr.email),
                      onSaved: (value) => _email = value,
                    ),
                    SizedBox(height: 0.02.sh),
                    OutlineFormField(
                      obscureText: true,
                      labelText: tr(LocaleTr.password),
                      onSaved: (value) => _password = value,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 0.02.sh),
            RoundButton(
              title: tr(LocaleTr.login),
              onPressed: _logIn,
            ),
            SizedBox(height: 0.05.sh),
            TextButton(
              onPressed: _createAccount,
              child: Text(
                tr(LocaleTr.noAccount),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
