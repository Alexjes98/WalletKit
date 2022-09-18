import 'package:flutter/material.dart';
import 'package:wallet_kit/constants/app_colors.dart';
import 'package:wallet_kit/constants/strings.dart';

var ConstAppBar = AppBar(
  backgroundColor: primaryColor,
  title: const Align(
    alignment: Alignment.centerLeft,
    child: Text(
      appName,
      style: TextStyle(fontWeight: FontWeight.bold),
    ),
  ),
  leading: const Icon(Icons.menu),
);
