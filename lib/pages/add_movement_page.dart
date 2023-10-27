import 'dart:core';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wallet_kit/DTO/movement_category_dto.dart';

import 'package:wallet_kit/constants/components.dart';
import 'package:wallet_kit/services/movement_category.dart';
import 'package:wallet_kit/widgets/date_picker.dart';
import 'package:wallet_kit/widgets/expense_income_selector.dart';
import 'package:wallet_kit/widgets/movement_type_select.dart';
import 'package:wallet_kit/widgets/textInput/input_text_field.dart';
import 'package:wallet_kit/constants/app_colors.dart';

import 'package:wallet_kit/DTO/movement_dto.dart';

import 'package:wallet_kit/utils/generator.dart';

import '../services/movements.dart';

class AddMovementPage extends StatefulWidget {
  const AddMovementPage({key}) : super(key: key);

  @override
  State<AddMovementPage> createState() => _AddMovementPageState();
}

class _AddMovementPageState extends State<AddMovementPage> {
  TextEditingController amountController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  var movement = {};
  void setMovementField(String field, var value) {
    movement[field] = value;
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
                    ExpenseIncomeSelector(setMovementValue: setMovementField),
                    InputTextField(
                      labelText: 'Amount',
                      hintText: '\$\$\$',
                      icon: Icons.attach_money,
                      keyboardType: TextInputType.number,
                      inputController: amountController,
                    ),
                    InputTextField(
                      labelText: 'Description',
                      hintText: 'A diner with friends...',
                      icon: Icons.list_alt_outlined,
                      keyboardType: TextInputType.multiline,
                      inputController: descriptionController,
                    ),
                    MoneyMovementCategorySelector(
                      setMovementValue: setMovementField,
                    ),
                    const InputTextField(
                      labelText: 'It has a debt?',
                      hintText: 'This money comes or goes to a debt?',
                      icon: Icons.timelapse,
                      keyboardType: TextInputType.multiline,
                    ),
                    DateSelectionRow(serDateValue: setMovementField),
                    ButtonBar(
                      alignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                            foregroundColor: white,
                          ),
                          onPressed: () async {
                            final dateFormat = DateFormat('yyyy-MM-dd');
                            MovementDTO newMovement = MovementDTO(
                              id: int.parse(generateRandomIdByDate()),
                              userId: 0,
                              transactionType: movement['movement_type'] == true
                                  ? 'income'
                                  : 'expense',
                              description: descriptionController.text,
                              source: 'source',
                              amount: movement['movement_type'] == true
                                  ? double.parse(amountController.text)
                                  : -double.parse(amountController.text),
                              movementCategory: movement['movement_category'],
                              debtId: 0,
                              date: dateFormat.parse(movement['date']),
                            );
                            final encryptionHelper = MovementsService();
                            await encryptionHelper
                                .saveEncryptedMovement(newMovement)
                                .then((value) => Navigator.of(context).pop());
                          },
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
                  icon: const Icon(Icons.arrow_back),
                )
              ],
            )),
      ),
    );
  }
}
