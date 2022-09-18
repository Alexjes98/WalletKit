import 'package:flutter/material.dart';
import 'package:wallet_kit/constants/app_colors.dart';
import 'package:wallet_kit/route_generator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WalletKit',
      theme: ThemeData(primaryColor: primaryColor),
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
