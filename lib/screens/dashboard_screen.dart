import 'package:caishen_wallet/controllers/dashboard_controller.dart';
import 'package:caishen_wallet/screens/widgets/adaptive_scroll_view.dart';
import 'package:caishen_wallet/screens/widgets/liquid_progress_indicator_widget.dart';
import 'package:caishen_wallet/utils/localizations.dart';
import 'package:caishen_wallet/utils/utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({
    Key? key,
  }) : super(key: key);

  static const String routeName = '/dashboard_screen';

  @override
  Widget build(BuildContext context) {
    final _dashboardcontroller = DashboardController();

    return Scaffold(
      body: SafeArea(
        child: AdaptiveScrollView(
          child: ListView(
            children: [
              DashboardItem(
                title: tr(LocaleTr.dashboardExpenses),
                streamValue: _dashboardcontroller.expenses(),
                amountColor: Utils.theme(context).errorColor,
              ),
              DashboardItem(
                title: tr(LocaleTr.dashboardIncomes),
                streamValue: _dashboardcontroller.incomes(),
                amountColor: Utils.theme(context).colorScheme.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DashboardItem extends StatelessWidget {
  const DashboardItem({
    Key? key,
    required this.title,
    required this.streamValue,
    required this.amountColor,
  }) : super(key: key);

  final String title;
  final Stream<double> streamValue;
  final Color amountColor;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: streamValue,
      builder: (
        BuildContext context,
        AsyncSnapshot<double> snapshot,
      ) {
        if (snapshot.connectionState == ConnectionState.active) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              color: Colors.grey[200],
            ),
            margin: EdgeInsets.only(
              top: 0.02.sh,
              right: 0.05.sw,
              left: 0.05.sw,
            ),
            padding: EdgeInsets.all(0.015.sh),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Utils.theme(context).textTheme.headline1,
                ),
                SizedBox(height: 0.005.sh),
                Text(
                  Utils.formatToMoney(snapshot.data!),
                  style: TextStyle(
                    color: amountColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
        } else {
          return const LiquidProgressIndicator();
        }
      },
    );
  }
}
