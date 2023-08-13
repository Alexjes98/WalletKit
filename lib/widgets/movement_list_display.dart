import 'package:flutter/material.dart';

import 'package:wallet_kit/constants/app_colors.dart';

class MovementListTile extends StatelessWidget {
  MovementListTile(
      {Key? key,
      this.amount,
      this.description,
      this.date,
      this.change,
      this.sign})
      : super(key: key);

  final amount;
  final change;
  final description;
  final date;
  final sign;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      color: primaryVariant.withOpacity(0.4),
      clipBehavior: Clip.none,
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: ListTile(
        leading: Text(
          '$amount $change',
          style: TextStyle(
              color: sign ? earnColor : expenseColor,
              fontWeight: FontWeight.bold,
              fontSize: 22),
        ),
        title: Text(
          '$description',
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
              color: white, fontWeight: FontWeight.bold, fontSize: 13),
        ),
        subtitle: Text(
          '$date',
          style: const TextStyle(color: white),
        ),
      ),
    );
  }
}
