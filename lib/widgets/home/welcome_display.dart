import 'package:flutter/material.dart';
import 'package:wallet_kit/constants/strings.dart';

import '../../constants/app_colors.dart';

class WelcomeDisplay extends StatelessWidget {
  const WelcomeDisplay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Welcome $userName',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: white),
          ),
          CircleAvatar(
            backgroundColor: primaryColor,
            radius: 25,
          )
        ],
      ),
    );
  }
}
