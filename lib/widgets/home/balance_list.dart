import 'package:flutter/material.dart';
import 'package:wallet_kit/constants/app_colors.dart';

import '../movement_list_display.dart';

class BalanceList extends StatelessWidget {
  const BalanceList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: const BoxDecoration(
          border: Border(
              top: BorderSide(color: primaryColor, width: 3),
              bottom: BorderSide(color: primaryColor, width: 3))),
      child: ListView(
        shrinkWrap: true,
        children: [
          MovementListTile(
            amount: 15,
            change: '\$',
            description: 'Burguers with friends and family',
            date: '1/12/2023',
            sign: false,
          ),
          MovementListTile(
            amount: 5,
            change: '\$',
            description: 'Burguers with friends and family',
            date: '1/12/2023',
            sign: true,
          ),
          MovementListTile(
            amount: 1,
            change: '\$',
            description: 'Burguers with friends and family',
            date: '1/12/2023',
            sign: false,
          ),
          MovementListTile(
            amount: 1,
            change: '\$',
            description: 'Burguers with friends and family',
            date: '1/12/2023',
            sign: true,
          ),
          MovementListTile(
            amount: 1,
            change: '\$',
            description: 'Burguers with friends and family',
            date: '1/12/2023',
            sign: false,
          ),
        ],
      ),
    );
  }
}
