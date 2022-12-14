import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';

import '../../constants/app_colors.dart';

class FloatingExpandableActionButton extends StatelessWidget {
  const FloatingExpandableActionButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpandableFab(
      key: key,
      backgroundColor: primaryColor,
      foregroundColor: white,
      type: ExpandableFabType.up,
      closeButtonStyle: const ExpandableFabCloseButtonStyle(
        child: Icon(Icons.close),
        foregroundColor: white,
        backgroundColor: primaryColor,
      ),
      child: const Icon(Icons.addchart),
      overlayStyle: ExpandableFabOverlayStyle(
        blur: 5,
      ),
      children: [
        FloatingActionButton(
          backgroundColor: primaryColor,
          foregroundColor: white,
          onPressed: () {
            Navigator.of(context).pushNamed('/addMovement');
          },
          child: const Icon(Icons.attach_money),
        ),
      ],
    );
  }
}
