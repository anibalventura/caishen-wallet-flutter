import 'dart:io';
import 'package:caishen_wallet/ui/screens/dashboard_screen.dart';
import 'package:caishen_wallet/ui/screens/more_screen.dart';
import 'package:caishen_wallet/ui/screens/transactions_screen.dart';
import 'package:caishen_wallet/utils/localizations.dart';
import 'package:caishen_wallet/utils/utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  static const String routeName = '/home_screen';

  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  int _selectedIndex = 1;

  final List<Widget> _navOptions = [
    const DashboardScreen(),
    TransactionsScreen(),
    const MoreScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _navOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Utils.theme(context).colorScheme.primary,
        items: [
          BottomNavigationBarItem(
            label: tr(LocaleTr.dashboard),
            icon: Icon(
              Platform.isAndroid
                  ? Icons.dashboard_outlined
                  : CupertinoIcons.doc_plaintext,
            ),
          ),
          BottomNavigationBarItem(
            label: tr(LocaleTr.transactions),
            icon: Icon(
              Platform.isAndroid
                  ? Icons.list_alt_rounded
                  : CupertinoIcons.list_bullet,
            ),
          ),
          BottomNavigationBarItem(
            label: tr(LocaleTr.more),
            icon: Icon(
              Platform.isAndroid
                  ? Icons.more_horiz_rounded
                  : CupertinoIcons.ellipsis,
            ),
          ),
        ],
        onTap: (index) {
          setState(() => _selectedIndex = index);
        },
      ),
    );
  }
}
