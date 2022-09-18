import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class MovementTypeSelector extends StatefulWidget {
  MovementTypeSelector({Key? key, @required this.setMovementValue})
      : super(key: key);

  var selectEar = false;
  var selectExp = false;
  final setMovementValue;

  @override
  State<MovementTypeSelector> createState() => _MovementTypeSelectorState();
}

class _MovementTypeSelectorState extends State<MovementTypeSelector> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
              onPressed: () {
                setState(() {
                  widget.selectEar = false;
                  widget.selectExp = true;
                  widget.setMovementValue(true);
                });
              },
              style: ElevatedButton.styleFrom(
                primary: widget.selectExp ? expenseColor : backgroundColor,
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
                  widget.setMovementValue(false);
                });
              },
              style: ElevatedButton.styleFrom(
                primary: widget.selectEar ? earnColor : backgroundColor,
                shadowColor: widget.selectEar ? earnColor : null,
              ),
              child: Icon(
                Icons.attach_money,
                color: widget.selectEar ? white : earnColor,
              )),
        ),
      ],
    );
  }
}
