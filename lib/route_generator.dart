import 'package:flutter/material.dart';
import 'package:wallet_kit/constants/strings.dart';
import 'package:wallet_kit/pages/add_debs_page.dart';
import 'package:wallet_kit/pages/add_movement_category_page.dart';
import 'package:wallet_kit/pages/add_movement_page.dart';
import 'package:wallet_kit/pages/add_person_page.dart';
import 'package:wallet_kit/pages/debs_page.dart';
import 'package:wallet_kit/pages/home_page.dart';
import 'package:wallet_kit/pages/persons_page.dart';
import 'package:wallet_kit/pages/profile_menu_page.dart';
import 'package:wallet_kit/pages/wallet_menu_page.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments ?? "";
    var name = settings.name;

    switch (name) {
      case '/':
        return MaterialPageRoute(builder: ((_) => const HomePage()));
      case '/home':
        return MaterialPageRoute(builder: ((_) => const HomePage()));
      case '/wallet':
        return MaterialPageRoute(builder: ((_) => const WalletMenuPage()));
      case '/profile':
        return MaterialPageRoute(builder: ((_) => const ProfileMenuPage()));
      case '/addMovement':
        return MaterialPageRoute(builder: ((_) => const AddMovementPage()));
      case '/addMovementCategory':
        return MaterialPageRoute(
            builder: ((_) => const AddMovementCategoryPage()));
      case '/addDebt':
        return MaterialPageRoute(builder: ((_) => const AddDebtPage()));
      case '/debts':
        return MaterialPageRoute(builder: ((_) => const DebsPage()));
      case '/addPerson':
        return MaterialPageRoute(builder: ((_) => const AddPersonPage()));
      case '/persons':
        return MaterialPageRoute(builder: ((_) => const PersonsPage()));
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(title: const Text(appName)),
        body: const Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
