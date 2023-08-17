import 'package:wallet_kit/DTO/balance_dto.dart';

import './movements.dart';

class BalancesService {
  Future<BalanceDTO> generateBalance() {
    MovementsService movementsService = MovementsService();
    return movementsService.getAllDecryptedMovements().then((movements) {
      double genBalance = 0;
      double monthBalance = 0;
      double genIncome = 0;
      double monthIncome = 0;
      double genExpenses = 0;
      double monthExpenses = 0;
      for (var movement in movements) {
        if (movement.transactionType == 'income') {
          genIncome += movement.amount;
          if (movement.date.month == DateTime.now().month) {
            monthIncome += movement.amount;
          }
        } else if (movement.transactionType == 'expense') {
          genExpenses += movement.amount;
          if (movement.date.month == DateTime.now().month) {
            monthExpenses += movement.amount;
          }
        }
        genBalance = genIncome + genExpenses;
        monthBalance = monthIncome + monthExpenses;
      }
      BalanceDTO dto = BalanceDTO.fromJson({
        'generalBalance': genBalance.toString(),
        'generalIncome': genIncome.toString(),
        'generalExpenses': genExpenses.toString(),
        'monthBalance': monthBalance.toString(),
        'monthIncome': monthIncome.toString(),
        'monthExpenses': monthExpenses.toString(),
      });
      return dto;
    });
  }
}
