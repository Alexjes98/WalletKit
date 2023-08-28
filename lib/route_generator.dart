import 'package:flutter/material.dart';
import 'package:wallet_kit/constants/strings.dart';
import 'package:wallet_kit/pages/add_debs_page.dart';
import 'package:wallet_kit/pages/add_movement_category_page.dart';
import 'package:wallet_kit/pages/add_movement_page.dart';
import 'package:wallet_kit/pages/home_page.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments ?? "";
    var name = settings.name;

    switch (name) {
      case '/':
        return MaterialPageRoute(builder: ((_) => const HomePage()));
      case '/addMovement':
        return MaterialPageRoute(builder: ((_) => const AddMovementPage()));
      case '/addMovementCategory':
        return MaterialPageRoute(builder: ((_) => const AddMovementCategoryPage()));
      case '/addDebt':
        return MaterialPageRoute(builder: ((_) => const AddDebtPage()));
        
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
