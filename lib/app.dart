import 'package:caishen_wallet/services/auth.dart';
import 'package:caishen_wallet/ui/screens/home_screen.dart';
import 'package:caishen_wallet/ui/screens/login_screen.dart';
import 'package:caishen_wallet/ui/themes.dart';
import 'package:caishen_wallet/utils/localizations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore_for_file: prefer_const_constructors
class CaishenWalletApp extends StatelessWidget {
  const CaishenWalletApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: () {
        return MaterialApp(
          title: LocaleTr.appName,
          theme: Themes.lightTheme,
          darkTheme: Themes.darkTheme,
          initialRoute: Auth.auth.currentUser != null
              ? HomeScreen.routeName
              : LoginScreen.routeName,
          routes: {
            LoginScreen.routeName: (_) => LoginScreen(),
            HomeScreen.routeName: (_) => HomeScreen(),
          },
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
        );
      },
    );
  }
}
