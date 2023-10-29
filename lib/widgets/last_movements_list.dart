import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wallet_kit/constants/app_colors.dart';
import 'package:wallet_kit/utils/formater.dart';

import '../DTO/movement_dto.dart';

class LastMovementsList extends StatelessWidget {
  final List<MovementDTO> movementsList;
  const LastMovementsList({super.key, required this.movementsList});

  @override
  Widget build(BuildContext context) {    
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
            itemCount: movementsList.length > 5 ? 5 : movementsList.length,
                  itemBuilder: (context, index) {
              MovementDTO movement = movementsList[index];
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
}
