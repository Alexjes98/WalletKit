import 'package:flutter/material.dart';

import '../DTO/movement_dto.dart';
import '../services/movements.dart';

class LastMovementsList extends StatelessWidget {
  final EncryptionHelper encryptionHelper = EncryptionHelper();
  late Future<List<MovementDTO>> decryptedMovements;
  LastMovementsList({super.key}) {
    decryptedMovements = _loadDecryptedMovements();
  }
  Future<List<MovementDTO>> _loadDecryptedMovements() async {
    List<MovementDTO> movements =
        await encryptionHelper.getAllDecryptedMovements();
    return movements.toList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<MovementDTO>>(
      future: decryptedMovements,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return const Text('Error loading movements');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Text('No movements available');
        } else {
          return Column(
            children: [
              const Text('Last movements',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  )),
              Expanded(
                child: ListView.builder(
                  itemCount:
                      snapshot.data!.length < 5 ? snapshot.data!.length : 5,
                  itemBuilder: (context, index) {
                    MovementDTO movement = snapshot.data![index];
                    return ListTile(
                      title: Text(movement.description),
                      subtitle: Text(
                          'Amount: \$${movement.amount.toStringAsFixed(2)} - ${movement.transactionType}',
                          style: TextStyle(
                            color: movement.transactionType == 'income'
                                ? Colors.green
                                : Colors.red,
                          )),
                      trailing: Text(
                        '${movement.date.day}/${movement.date.month}/${movement.date.year}',
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
