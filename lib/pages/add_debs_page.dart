import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wallet_kit/DTO/debt_dto.dart';
import 'package:wallet_kit/constants/app_colors.dart';
import 'package:wallet_kit/constants/components.dart';
import 'package:wallet_kit/services/debts.dart';
import 'package:wallet_kit/utils/generator.dart';
import 'package:wallet_kit/widgets/date_picker.dart';
import 'package:wallet_kit/widgets/persons_select.dart';
import 'package:wallet_kit/widgets/textInput/input_text_field.dart';

class AddDebtPage extends StatefulWidget {
  const AddDebtPage({super.key});

  @override
  State<AddDebtPage> createState() => _AddDebtPageState();
}

class _AddDebtPageState extends State<AddDebtPage> {
  var debt = {};
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _coveredAmountController = TextEditingController();

  void setDebtField(String field, var value) {
    debt[field] = value;
  }

  setFromPerson(int id, String name) {
    setState(() {
      debt['fromPersonId'] = id;
      debt['fromPersonName'] = name;
    });
  }

  setToPerson(int id, String name) {
    setState(() {
      debt['toPersonId'] = id;
      debt['toPersonName'] = name;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: ConstAppBar,
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Expanded(
            child: ListView(
          padding:
              const EdgeInsets.only(top: 10, bottom: 50, left: 10, right: 10),
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: const Text(
                'Add a debt',
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 33),
              ),
            ),
            InputTextField(
              labelText: 'Amount',
              hintText: '\$\$\$',
              icon: Icons.attach_money,
              keyboardType: TextInputType.number,
              inputController: _amountController,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'From:',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                Expanded(
                    child: PersonsSelect(onChangeDropdownItem: setFromPerson)),
                const Icon(
                  Icons.arrow_forward_sharp,
                  color: primaryColor,
                ),
                const Text(
                  'To:',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                Expanded(
                    child: PersonsSelect(onChangeDropdownItem: setToPerson)),
              ],
            ),
            InputTextField(
              labelText: 'Covered amount',
              hintText: '\$\$\$',
              icon: Icons.attach_money,
              keyboardType: TextInputType.number,
              inputController: _coveredAmountController,
            ),
            InputTextField(
              labelText: 'Description',
              hintText: 'Description',
              icon: Icons.description,
              keyboardType: TextInputType.text,
              inputController: _descriptionController,
            ),
            DateSelectionRow(serDateValue: setDebtField),
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
                    final newDebt = DebtDTO(
                        id: int.parse(generateRandomIdByDate()),
                        amount: double.parse(_amountController.text),
                        coveredAmount:
                            double.parse(_coveredAmountController.text),
                        from: debt['fromPersonId'],
                        fromName: debt['fromPersonName'],
                        to: debt['toPersonId'],
                        toName: debt['toPersonName'],
                        description: _descriptionController.text,
                        date: dateFormat.parse(debt['date']));
                    final encryptionHelper = DebtsService();
                    await encryptionHelper
                        .saveEncryptedDebt(newDebt)
                        .then((value) => {Navigator.of(context).pop()})
                        .catchError((error) => print(error));
                  },
                  child: const Text('Add debt'),
                )
              ],
            )
          ],
        ))
      ]),
    ));
  }
}
