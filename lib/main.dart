import 'package:caishen_wallet/app.dart';
import 'package:caishen_wallet/services/firebase_options.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Init locale translations.
  await EasyLocalization.ensureInitialized();

  // Init Firebase services.
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Lock screen to portrait.
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(
    EasyLocalization(
      path: 'assets/lang',
      fallbackLocale: const Locale('en'),
      supportedLocales: const [
        Locale('en'),
        Locale('es'),
      ],
      child: const CaishenWalletApp(),
    ),
  );
}
