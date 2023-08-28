import 'package:flutter/material.dart';
import 'package:wallet_kit/constants/app_colors.dart';
import 'package:wallet_kit/constants/components.dart';
import 'package:wallet_kit/widgets/textInput/input_text_field.dart';

class AddDebtPage extends StatefulWidget {
  const AddDebtPage({super.key});

  @override
  State<AddDebtPage> createState() => _AddDebtPageState();
}

class _AddDebtPageState extends State<AddDebtPage> {
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
              inputController: null,
            ),
          ],
        ))
      ]),
    ));
  }
}
