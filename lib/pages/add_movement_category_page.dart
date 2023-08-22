import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:wallet_kit/services/movement_category.dart';
import 'package:wallet_kit/utils/generator.dart';

import '../DTO/movement_category_dto.dart';
import '../constants/app_colors.dart';
import '../constants/components.dart';
import '../widgets/textInput/input_text_field.dart';

class AddMovementCategoryPage extends StatefulWidget {
  const AddMovementCategoryPage({Key? key}) : super(key: key);

  @override
  State<AddMovementCategoryPage> createState() =>
      _AddMovementCategoryPageState();
}

class _AddMovementCategoryPageState extends State<AddMovementCategoryPage> {
  TextEditingController categoryNameController = TextEditingController();
  TextEditingController categoryDetailsController = TextEditingController();
  Icon? _icon;

  _pickIcon() async {
    IconData? icon = await FlutterIconPicker.showIconPicker(context,
        iconPackModes: [IconPack.material]);

    _icon = Icon(icon);

    setState(() {});
    debugPrint('Picked Icon:  $icon');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: backgroundColor,
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
                'Add movement category',
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 22),
              ),
            ),
            Column(
              children: [
                InputTextField(
                  labelText: 'Category name',
                  hintText: 'Some personal preference',
                  icon: Icons.attach_money,
                  keyboardType: TextInputType.text,
                  inputController: categoryNameController,
                ),
                InputTextField(
                  labelText: 'Details',
                  hintText: 'Details',
                  icon: Icons.details,
                  keyboardType: TextInputType.text,
                  inputController: categoryDetailsController,
                ),
                const Text(
                  'Select an icon',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 22),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: () {
                          _icon = const Icon(Icons.food_bank);
                          setState(() {});
                        },
                        icon: const Icon(Icons.food_bank)),
                    IconButton(
                        onPressed: () {
                          _icon = const Icon(Icons.shopping_cart);
                          setState(() {});
                        },
                        icon: const Icon(Icons.shopping_cart)),
                    IconButton(
                        onPressed: () {
                          _icon = const Icon(Icons.nightlife);
                          setState(() {});
                        },
                        icon: const Icon(Icons.nightlife)),
                    IconButton(
                        onPressed: () {
                          _icon = const Icon(Icons.health_and_safety);
                          setState(() {});
                        },
                        icon: const Icon(Icons.health_and_safety)),
                    IconButton(
                        onPressed: () {
                          _icon = const Icon(Icons.airplane_ticket);
                          setState(() {});
                        },
                        icon: const Icon(Icons.airplane_ticket)),
                    IconButton(
                        onPressed: () {
                          _icon = const Icon(Icons.shopify);
                          setState(() {});
                        },
                        icon: const Icon(Icons.shopify)),
                  ],
                ),
                ElevatedButton(
                  onPressed: _pickIcon,
                  child: const Text('Advanced Icon Picker'),
                ),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: _icon ?? Container(),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: ElevatedButton(
                    onPressed: () async {
                      final movementCategory = MovementCategoryDTO(
                          id: int.parse(generateRandomIdByDate()),
                          name: categoryNameController.text,
                          details: categoryDetailsController.text,
                          icon: _icon?.icon ?? Icons.error);
                      MovementCategoryService movementCategoryService =
                          MovementCategoryService();
                      await movementCategoryService
                          .saveEncryptedMovementCategory(movementCategory);

                      final createdCategory = await movementCategoryService
                          .getDecryptedMovementCategory(movementCategory.id);
                      print(createdCategory?.toJson());
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 10),
                        textStyle: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    child: const Text('Add category',
                        style: TextStyle(color: backgroundColor)),
                  ),
                ),
              ],
            ),
          ],
        ))
      ]),
    ));
  }
}
