import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wallet_kit/services/movements.dart';
import 'package:state_notifier/state_notifier.dart';

// movements state for the app
final allMovementsProvider = FutureProvider((ref) async {
  return ref.read(movementsProvider).getAllDecryptedMovements();
});
