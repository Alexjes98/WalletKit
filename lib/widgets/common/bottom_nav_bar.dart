import 'package:flutter/material.dart';
import 'package:wallet_kit/constants/app_colors.dart';

class WalletNavBar extends StatelessWidget {
  const WalletNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: primaryColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            onPressed: () => Navigator.pushReplacementNamed(context, '/'),
            icon: const Icon(Icons.home),
            color: backgroundColor,
          ),
          IconButton(
            onPressed: () => Navigator.pushNamed(context, '/movements'),
            icon: const Icon(Icons.account_balance_wallet),
            color: backgroundColor,
          ),
          IconButton(
            onPressed: () => Navigator.pushNamed(context, '/profile'),
            icon: const Icon(Icons.person),
            color: backgroundColor,
          ),
          IconButton(
            onPressed: () => Navigator.pushNamed(context, '/settings'),
            icon: const Icon(Icons.settings),
            color: backgroundColor,
          ),
        ],
      ),
    );
  }
}
