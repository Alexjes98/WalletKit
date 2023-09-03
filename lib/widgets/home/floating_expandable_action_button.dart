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
          heroTag: 'addMovement',
          backgroundColor: primaryColor,
          foregroundColor: white,
          onPressed: () {
            Navigator.of(context).pushNamed('/addMovement');
          },
          child: const Icon(Icons.attach_money),
        ),
        FloatingActionButton(
          heroTag: 'addMovementCategory',
          backgroundColor: primaryColor,
          foregroundColor: white,
          onPressed: () {
            Navigator.of(context).pushNamed('/addMovementCategory');
          },
          child: const Icon(Icons.category),
        ),
        FloatingActionButton(
          heroTag: 'addDebt',
          backgroundColor: primaryColor,
          foregroundColor: white,
          onPressed: () {
            Navigator.of(context).pushNamed('/addDebt');
          },
          child: const Icon(Icons.book),
        ),
        FloatingActionButton(
          heroTag: 'addPerson',
          backgroundColor: primaryColor,
          foregroundColor: white,
          onPressed: () {
            Navigator.of(context).pushNamed('/addPerson');
          },
          child: const Icon(Icons.person),
        ),
        FloatingActionButton(
          heroTag: 'persons',
          backgroundColor: primaryColor,
          foregroundColor: white,
          onPressed: () {
            Navigator.of(context).pushNamed('/persons');
          },
          child: const Icon(Icons.people),
        ),
      ],
    );
  }
}
