import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';

class BalanceDisplay extends StatelessWidget {
  const BalanceDisplay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(35),
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'General balance 0\$',
                style: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 28),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
