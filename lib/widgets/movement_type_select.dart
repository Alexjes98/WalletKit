import 'package:flutter/material.dart ';
import 'package:wallet_kit/constants/app_colors.dart';

import 'package:wallet_kit/styles/text/texts.dart';

class MoneyMovementCategorySelector extends StatefulWidget {
  @override
  _MoneyMovementCategorySelectorState createState() =>
      _MoneyMovementCategorySelectorState();
}

class _MoneyMovementCategorySelectorState
    extends State<MoneyMovementCategorySelector> {
  num selectedTypes = 0;

  Map<num, String> movementTypes = {
    1: 'Food',
    2: 'Fun',
    3: 'Health',
    4: 'Saves',
    5: 'Travels',
    6: 'Debts',
    7: 'Gym',
  };

  void _toggleMovementType(num typeId) {
    setState(() {
      selectedTypes = typeId;
    });
  }

  String _getSelectedTypesString() {
    return selectedTypes.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'What type of movement is it?',
          style: basic_form_title,
        ),
        Wrap(
          spacing: 8,
          children: movementTypes.keys.map((typeId) {
            return ChoiceChip(
              selectedColor: primaryColor,
              backgroundColor: primaryLight,
              label: Text(movementTypes[typeId]!),
              selected: selectedTypes == typeId,
              onSelected: (selected) => _toggleMovementType(typeId),
            );
          }).toList(),
        ),
      ],
    );
  }
}
