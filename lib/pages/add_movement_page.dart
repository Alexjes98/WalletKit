import 'package:flutter/material.dart';
import 'package:wallet_kit/constants/components.dart';
import 'package:wallet_kit/constants/margins.dart';
import 'package:wallet_kit/widgets/date_picker.dart';
import 'package:wallet_kit/widgets/expense_income_selector.dart';
import 'package:wallet_kit/widgets/movement_type_select.dart';
import 'package:wallet_kit/widgets/textInput/input_text_field.dart';

import 'package:wallet_kit/constants/app_colors.dart';
import 'package:wallet_kit/styles/text/texts.dart';
import '../constants/strings.dart';

class AddMovementPage extends StatelessWidget {
  AddMovementPage({Key? key}) : super(key: key);

  TextEditingController amountController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  var movement;

  void setMovement(value) {
    movement = value;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: ConstAppBar,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                child: ListView(
              padding: const EdgeInsets.only(
                  top: 10, bottom: 50, left: 10, right: 10),
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: const Text(
                    'Add movement',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 33),
                  ),
                ),
                Column(
                  children: [
                    ExpenseIncomeSelector(setMovementValue: setMovement),
                    const InputTextField(
                      labelText: 'Amount',
                      hintText: '\$\$\$',
                      icon: Icons.attach_money,
                    ),
                    const InputTextField(
                      labelText: 'Description',
                      hintText: 'A diner with friends...',
                      icon: Icons.list_alt_outlined,
                      keyboardType: TextInputType.multiline,
                    ),
                    MoneyMovementCategorySelector(),
                    const InputTextField(
                      labelText: 'It has a debt?',
                      hintText: 'This money comes or goes to a debt?',
                      icon: Icons.timelapse,
                      keyboardType: TextInputType.multiline,
                    ),
                    DateSelectionRow(),
                    ButtonBar(
                      alignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                            foregroundColor: white,
                          ),
                          onPressed: () {},
                          child: const Text('Add movement'),
                        )
                      ],
                    )
                  ],
                )
              ],
            ))
          ],
        ),
        bottomNavigationBar: BottomAppBar(
            color: primaryVariant,
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.arrow_back),
                )
              ],
            )),
      ),
    );
  }
}
