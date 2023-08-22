import 'package:flutter/material.dart';
import 'package:wallet_kit/constants/app_colors.dart';
import 'package:wallet_kit/constants/components.dart';
import 'package:wallet_kit/widgets/home/balance_display.dart';
import 'package:wallet_kit/widgets/home/floating_expandable_action_button.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';

import 'package:wallet_kit/services/movements.dart';
import 'package:wallet_kit/widgets/last_movements_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: ConstAppBar,
        body: Column(
          children: [
            BalanceDisplay(),
            ButtonBar(
              alignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    MovementsService movementsService = MovementsService();
                    await movementsService.deleteAllEncryptedMovements();
                    setState(() {});
                  },
                  child: const Text('DELETE'),
                ),
              ],
            ),
            
            Expanded(child: LastMovementsList())
          ],
        ),
        floatingActionButtonLocation: ExpandableFab.location,
        floatingActionButton: const FloatingExpandableActionButton(),
      ),
    );
  }
}
