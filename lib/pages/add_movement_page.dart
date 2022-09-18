import 'package:flutter/material.dart';
import 'package:wallet_kit/constants/components.dart';
import 'package:wallet_kit/constants/margins.dart';
import 'package:wallet_kit/widgets/movement_type_selector.dart';
import 'package:wallet_kit/widgets/textInput/input_text_field.dart';

import '../constants/app_colors.dart';
import '../constants/strings.dart';

class AddMovementPage extends StatelessWidget {
  AddMovementPage({Key? key}) : super(key: key);

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
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: mainMarginH),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                  child: ListView(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: const Text(
                      'Add movement',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 33),
                    ),
                  ),
                  Column(
                    children: [
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Type:',
                          style: TextStyle(color: primaryColor, fontSize: 18),
                        ),
                      ),
                      const InputTextField(
                        labelText: 'Amount',
                        hintText: '10\$',
                        icon: Icons.attach_money,
                      ),
                      const InputTextField(
                        labelText: 'Description',
                        hintText: 'A diner with friends...',
                        icon: Icons.list_alt_outlined,
                        keyboardType: TextInputType.multiline,
                      ),
                      MovementTypeSelector(
                        setMovementValue: setMovement,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Category',
                            style: TextStyle(
                              color: primaryColor,
                              fontSize: 18,
                            )),
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: Container(
                                  color: primaryVariant, child: Container()))
                        ],
                      )
                    ],
                  )
                ],
              ))
            ],
          ),
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
