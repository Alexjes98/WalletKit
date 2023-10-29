import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wallet_kit/constants/app_colors.dart';
import 'package:wallet_kit/utils/formater.dart';

import '../DTO/movement_dto.dart';
import '../services/movements.dart';

class LastMovementsList extends StatelessWidget {
  final MovementsService movementService = MovementsService();
  late Future<List<MovementDTO>> decryptedMovements;
  LastMovementsList({super.key}) {
    decryptedMovements = _loadDecryptedMovements();
  }
  Future<List<MovementDTO>> _loadDecryptedMovements() async {
    List<MovementDTO> movements =
        await movementService.getAllDecryptedMovements();
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
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 1),
                child: Text(
                  'Last movements',
                  style: GoogleFonts.montserrat(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount:
                      snapshot.data!.length < 5 ? snapshot.data!.length : 5,
                  itemBuilder: (context, index) {
                    MovementDTO movement = snapshot.data![index];
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 2),
                      child: Material(
                        child: ListTile(
                          dense: true,
                          textColor: backgroundColor,
                          tileColor: primaryLight,
                          iconColor: movement.transactionType == 'income'
                              ? earnColor
                              : expenseColor,
                          leading: Icon(
                            size: 20,
                            movement.transactionType == 'income'
                                ? Icons.arrow_upward
                                : Icons.arrow_downward,
                          ),
                          title: Text(
                            movement.description.isEmpty
                                ? 'No description'
                                : movement.description,
                            style: GoogleFonts.montserrat(
                              fontSize: 15,
                            ),
                          ),
                          subtitle: Text(
                            '${movement.date.day}/${movement.date.month}/${movement.date.year}',
                          ),
                          trailing: Text(
                            '\$${toMoneyFormat(movement.amount.abs())}',
                            style: GoogleFonts.montserrat(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: primaryContrast),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              IconButton(
                onPressed: () => {},
                icon: const Icon(Icons.more_horiz),
                color: primaryColor,
              )
            ],
          );
        }
      },
    );
  }
}
