import 'package:caishen_wallet/services/auth.dart';
import 'package:caishen_wallet/ui/screens/dashboard_screen.dart';
import 'package:caishen_wallet/ui/screens/home_screen.dart';
import 'package:caishen_wallet/ui/screens/login_screen.dart';
import 'package:caishen_wallet/ui/screens/more_screen.dart';
import 'package:caishen_wallet/ui/screens/transactions_screen.dart';
import 'package:caishen_wallet/ui/themes.dart';
import 'package:caishen_wallet/ui/widgets/liquid_progress_indicator_widget.dart';
import 'package:caishen_wallet/utils/localizations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
          routes: {
            LoginScreen.routeName: (_) => LoginScreen(),
            HomeScreen.routeName: (_) => HomeScreen(),
            DashboardScreen.routeName: (_) => DashboardScreen(),
            TransactionsScreen.routeName: (_) => TransactionsScreen(),
            MoreScreen.routeName: (_) => MoreScreen(),
          },
          home: StreamBuilder(
            stream: Auth().user,
            builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.data?.uid == null) {
                  return LoginScreen();
                } else {
                  return HomeScreen();
                }
              } else {
                return Scaffold(
                  body: LiquidProgressIndicator(),
                );
              }
            },
          ),
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
        );
      },
    );
  }
}
