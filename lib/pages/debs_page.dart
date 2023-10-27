import 'package:flutter/material.dart';
import 'package:wallet_kit/constants/app_colors.dart';
import 'package:wallet_kit/widgets/debs_list.dart';

class DebsPage extends StatelessWidget {
  const DebsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: backgroundColor,
      body: Column(
        children: [Expanded(child: DebtsList())],
      ),
    ));
  }
}
