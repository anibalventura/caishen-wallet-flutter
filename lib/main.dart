import 'package:caishen_wallet/app.dart';
import 'package:caishen_wallet/services/firebase_options.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  // Binding widgets.
  WidgetsFlutterBinding.ensureInitialized();

  // Init locale translations.
  await EasyLocalization.ensureInitialized();

  // Init Firebase services.
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
