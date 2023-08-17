import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wallet_kit/DTO/balance_dto.dart';

import '../../constants/app_colors.dart';
import '../../services/balances.dart';

class BalanceDisplay extends StatelessWidget {
  BalancesService balancesService = BalancesService();
  late Future<BalanceDTO> balance;

  BalanceDisplay({super.key}) {
    balance = balancesService.generateBalance();
  }

  @override
  Widget build(BuildContext context) {
    String monthName = DateFormat.MMMM().format(DateTime.now());
    return FutureBuilder<BalanceDTO>(
      future: balance,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return const Text('Error loading movements');
        } else if (!snapshot.hasData) {
          return const Text('No movements available');
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text('Account info',
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: primaryColor)),
            ExpansionTile(
                title: Text(
                  'General balance \$ ${snapshot.data!.generalBalance}',
                  style: const TextStyle(
                      color: balanceColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                children: <Widget>[
                  ListTile(
                    title: const Text(
                      'General income',
                      style: TextStyle(
                          color: earnColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                    trailing: Text(
                      '\$ ${snapshot.data!.generalIncome}',
                      style: const TextStyle(
                          color: earnColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                  ),
                  ListTile(
                    title: const Text(
                      'General expenses',
                      style: TextStyle(
                          color: expenseColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                    trailing: Text(
                      '\$ ${snapshot.data!.generalExpenses}',
                      style: const TextStyle(
                          color: expenseColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                  ),
                ]),
            ExpansionTile(
              title: Text(
                '$monthName balance \$ ${snapshot.data!.monthBalance}',
                style: const TextStyle(
                    color: balanceColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              children: <Widget>[
                ListTile(
                  title: Text(
                    '$monthName income',
                    style: const TextStyle(
                        color: earnColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                  trailing: Text(
                    '\$ ${snapshot.data!.monthIncome}',
                    style: const TextStyle(
                        color: earnColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                ),
                ListTile(
                    title: Text(
                      '$monthName expenses',
                      style: const TextStyle(
                          color: expenseColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                    trailing: Text(
                      '\$ ${snapshot.data!.monthExpenses}',
                      style: const TextStyle(
                          color: expenseColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ))
              ],
            ),
          ],
        );
      },
    );
  }
}
