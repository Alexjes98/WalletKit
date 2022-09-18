import 'package:flutter/material.dart';
import 'package:wallet_kit/constants/app_colors.dart';
import 'package:wallet_kit/constants/components.dart';
import 'package:wallet_kit/constants/margins.dart';
import 'package:wallet_kit/constants/strings.dart';
import 'package:wallet_kit/globals.dart';
import 'package:wallet_kit/widgets/home/balance_display.dart';
import 'package:wallet_kit/widgets/home/balance_list.dart';
import 'package:wallet_kit/widgets/home/floating_expandable_action_button.dart';
import 'package:wallet_kit/widgets/home/welcome_display.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: ConstAppBar,
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: mainMarginH),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    const WelcomeDisplay(),
                    const BalanceDisplay(),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 35),
                      child: Column(children: [
                        const Text(
                          'Month resume',
                          style: TextStyle(
                              color: primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5),
                              child: Text(
                                '85\$',
                                style: TextStyle(
                                    color: balanceColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5),
                              child: Text(
                                '100\$',
                                style: TextStyle(
                                    color: earnColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5),
                              child: Text(
                                '15\$',
                                style: TextStyle(
                                    color: expenseColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              ),
                            ),
                          ],
                        )
                      ]),
                    ),
                    Container(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2),
                            child: Text(
                              '$actualMonth last movements',
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: primaryVariant),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const BalanceList(),
                    const Icon(
                      Icons.more_horiz,
                      color: primaryColor,
                      size: 40,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: ExpandableFab.location,
        floatingActionButton: FloatingExpandableActionButton(),
      ),
    );
  }
}
