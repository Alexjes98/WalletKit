import 'package:flutter/material.dart ';
import 'package:wallet_kit/DTO/movement_category_dto.dart';
import 'package:wallet_kit/constants/app_colors.dart';

import 'package:wallet_kit/styles/text/texts.dart';

import '../services/movement_category.dart';

class MoneyMovementCategorySelector extends StatefulWidget {
  const MoneyMovementCategorySelector(
      {super.key, required this.setMovementValue});
  final Function setMovementValue;
  @override
  State<MoneyMovementCategorySelector> createState() =>
      _MoneyMovementCategorySelectorState();
}

class _MoneyMovementCategorySelectorState
    extends State<MoneyMovementCategorySelector> {
  MovementCategoryService movementCategoryService = MovementCategoryService();
  late Future<List<MovementCategoryDTO>> decryptedMovementCategories;

  _MoneyMovementCategorySelectorState() {
    decryptedMovementCategories = _loadDecryptedMovementCategories();
  }

  Future<List<MovementCategoryDTO>> _loadDecryptedMovementCategories() async {
    List<MovementCategoryDTO> categories =
        await movementCategoryService.getAllDecryptedMovementCategories();
    return categories.toList();
  }

  num selectedTypes = 0;

  void toggleMovementType(num typeId) {
    setState(() {
      selectedTypes = typeId;
    });
    widget.setMovementValue('movement_category', typeId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: decryptedMovementCategories,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return const Text('Error loading movement categories');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Text('No movement categories available');
        } else {
          return SizedBox(
            height: 300,
            child: Column(
              children: [
                const Text('Select movement category',
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: primaryColor)),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      MovementCategoryDTO movementCategory =
                          snapshot.data![index];
                      return ListTile(
                        onTap: () {
                          toggleMovementType(movementCategory.id);
                        },
                        dense: true,
                        title: Text(
                          movementCategory.name,
                          style: const TextStyle(
                              color: primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                        subtitle: Text(movementCategory.details,
                            style: TextStyle(fontSize: 10)),
                        trailing: Icon(
                          movementCategory.icon,
                          size: 30,
                          color: primaryColor,
                        ),
                        leading: Radio<num>(
                          value: movementCategory.id,
                          groupValue: selectedTypes,
                          onChanged: (num? typeId) {
                            toggleMovementType(typeId!);
                          },
                        ),
                      );
                    },
                  ),
                ),
                const Divider(
                  color: primaryColor,
                  thickness: 2,
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
