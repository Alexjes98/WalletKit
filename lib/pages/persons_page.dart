import 'package:flutter/material.dart';

import 'package:wallet_kit/constants/app_colors.dart';
import 'package:wallet_kit/constants/components.dart';
import 'package:wallet_kit/widgets/persons_list.dart';

class PersonsPage extends StatefulWidget {
  const PersonsPage({super.key});

  @override
  State<PersonsPage> createState() => _PersonsPageState();
}

class _PersonsPageState extends State<PersonsPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: backgroundColor,
      appBar: ConstAppBar,
      body: Column(
        children: [Expanded(child: PersonsList())],
      ),
    ));
  }
}
