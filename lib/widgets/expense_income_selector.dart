import 'package:flutter/material.dart';
import 'package:wallet_kit/constants/app_colors.dart';

import 'package:wallet_kit/styles/text/texts.dart';

class ExpenseIncomeSelector extends StatefulWidget {
  ExpenseIncomeSelector({Key? key, required this.setMovementValue})
      : super(key: key);

  var selectEar = false;
  var selectExp = false;
  Function setMovementValue;

  @override
  State<ExpenseIncomeSelector> createState() => _ExpenseIncomeSelectorState();
}

class _ExpenseIncomeSelectorState extends State<ExpenseIncomeSelector> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Expense or Income?',
            style: basic_form_title,
          ),
        ),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      widget.selectEar = false;
                      widget.selectExp = true;
                    });
                    widget.setMovementValue("movement_type", false);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        widget.selectExp ? expenseColor : backgroundColor,
                    shadowColor: widget.selectExp ? expenseColor : null,
                  ),
                  child: Icon(
                    Icons.attach_money,
                    color: widget.selectExp ? white : expenseColor,
                  )),
            ),
            Expanded(
              child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      widget.selectEar = true;
                      widget.selectExp = false;
                    });
                    widget.setMovementValue("movement_type", true);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        widget.selectEar ? earnColor : backgroundColor,
                    shadowColor: widget.selectEar ? earnColor : null,
                  ),
                  child: Icon(
                    Icons.attach_money,
                    color: widget.selectEar ? white : earnColor,
                  )),
            ),
          ],
        ),
      ],
    );
  }
}
