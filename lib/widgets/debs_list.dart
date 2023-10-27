import 'package:flutter/material.dart';
import 'package:wallet_kit/DTO/debt_dto.dart';
import 'package:wallet_kit/services/debts.dart';

class DebtsList extends StatelessWidget {
  final DebtsService debtsService = DebtsService();
  late Future<List<DebtDTO>> decryptedDebts;
  Future<List<DebtDTO>> _loadDecryptedDebts() async {
    List<DebtDTO> debts = await debtsService.getAllDecryptedDebts();
    return debts.toList();
  }

  DebtsList({Key? key}) : super(key: key) {
    decryptedDebts = _loadDecryptedDebts();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: decryptedDebts,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return const Text('Error loading debts');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Text('No debts available');
        } else {
          return Expanded(
              child: ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    DebtDTO debt = snapshot.data![index];
                    return ListTile(
                      leading: const Icon(Icons.person),
                      title: Text(debt.description),
                      subtitle: Column(
                        children: [
                          Text('${debt.coveredAmount}'),
                          Text('${debt.amount}'),
                          Text(debt.fromName),
                          Text(debt.toName),
                          Text('${debt.date}')
                        ],
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () async {},
                      ),
                    );
                  }));
        }
      },
    );
  }
}
