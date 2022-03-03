import 'package:caishen_wallet/app.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

Future<void> main() async {

  // Binding widgets.
  WidgetsFlutterBinding.ensureInitialized();

  // Init locale translations.
  await EasyLocalization.ensureInitialized();

  runApp(
    // Init locale translations.
    EasyLocalization(
      path: 'assets/lang',
      fallbackLocale: const Locale('en'),
      supportedLocales: const [
        Locale('en'),
        Locale('es'),
      ],
      // ignore: prefer_const_constructors
      child: CaishenWalletApp(),
    ),
  );
}
