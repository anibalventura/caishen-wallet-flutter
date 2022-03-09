import 'package:caishen_wallet/services/auth.dart';
import 'package:caishen_wallet/ui/screens/login_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const String routeName = '/home_screen';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        child: const Text('LogOut'),
        onPressed: () {
          Auth.signOut();
          Navigator.of(context).popAndPushNamed(LoginScreen.routeName);
        },
      ),
    );
  }
}
