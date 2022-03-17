import 'package:caishen_wallet/controllers/transaction_controller.dart';
import 'package:caishen_wallet/screens/add_transaction_screen.dart';
import 'package:caishen_wallet/screens/dashboard_screen.dart';
import 'package:caishen_wallet/screens/home_screen.dart';
import 'package:caishen_wallet/screens/login_screen.dart';
import 'package:caishen_wallet/screens/more_screen.dart';
import 'package:caishen_wallet/screens/profile_screen.dart';
import 'package:caishen_wallet/screens/transactions_screen.dart';
import 'package:caishen_wallet/screens/widgets/liquid_progress_indicator_widget.dart';
import 'package:caishen_wallet/services/auth.dart';
import 'package:caishen_wallet/utils/localizations.dart';
import 'package:caishen_wallet/utils/themes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class CaishenWalletApp extends StatelessWidget {
  const CaishenWalletApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<TransactionController>(
          create: (_) => TransactionController(),
        ),
      ],
      child: ScreenUtilInit(
        builder: () {
          return MaterialApp(
            title: LocaleTr.appName,
            theme: Themes.lightTheme,
            darkTheme: Themes.darkTheme,
            routes: {
              DashboardScreen.routeName: (_) => const DashboardScreen(),
              TransactionsScreen.routeName: (_) => TransactionsScreen(),
              AddTransactionScreen.routeName: (_) => AddTransactionScreen(),
              MoreScreen.routeName: (_) => const MoreScreen(),
              ProfileScreen.routeName: (_) => const ProfileScreen(),
            },
            home: StreamBuilder(
              stream: Auth().user,
              builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  if (snapshot.data?.uid == null) {
                    return const LoginScreen();
                  } else {
                    return const HomeScreen();
                  }
                } else {
                  return const Scaffold(
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
      ),
    );
  }
}
