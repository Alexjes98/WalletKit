import 'dart:convert';

import 'package:encrypt/encrypt.dart';
import 'package:wallet_kit/DTO/debt_dto.dart';
import 'package:wallet_kit/utils/encryption_helper.dart';

class DebtsService {
  final EncryptionHelper _encryptionHelper = EncryptionHelper();
  final _storageKey = 'debts';

  Future<void> saveEncryptedDebt(DebtDTO debt) async {
    final jsonString = json.encode(debt.toJson());
    final encrypter = Encrypter(AES(_encryptionHelper.key, mode: AESMode.cbc));
    final encrypted = encrypter.encrypt(jsonString, iv: _encryptionHelper.iv);
    var debts = await _encryptionHelper.storage.read(key: _storageKey);
    if (debts == null) {
      await _encryptionHelper.storage
          .write(key: _storageKey, value: encrypted.base64);
    } else {
      await _encryptionHelper.storage
          .write(key: _storageKey, value: '$debts,${encrypted.base64}');
    }
  }

  Future<void> deleteEncryptedDebt(int id) async {
    final encryptedMovements =
        await _encryptionHelper.storage.read(key: _storageKey);
    if (encryptedMovements != null) {
      final encrypter =
          Encrypter(AES(_encryptionHelper.key, mode: AESMode.cbc));
      final encryptedValues = encryptedMovements.split(',');
      final List<String> newEncryptedValues = [];
      for (var encryptedValue in encryptedValues) {
        try {
          final decrypted =
              encrypter.decrypt64(encryptedValue, iv: _encryptionHelper.iv);
          final decodedJson = json.decode(decrypted);
          final movement = DebtDTO.fromJson(decodedJson);
          if (movement.id != id) {
            newEncryptedValues.add(encryptedValue);
          }
        } catch (e) {
          // Handle decryption errors
        }
      }
      await _encryptionHelper.storage
          .write(key: _storageKey, value: newEncryptedValues.join(','));
    }
  }

  Future<void> deleteAllEncryptedDebts() async {
    await _encryptionHelper.storage.delete(key: _storageKey);
  }

  Future<List<DebtDTO>> getAllDecryptedDebts() async {
    final encryptedDebts =
        await _encryptionHelper.storage.read(key: _storageKey);
    if (encryptedDebts != null) {
      final encrypter =
          Encrypter(AES(_encryptionHelper.key, mode: AESMode.cbc));
      final encryptedValues = encryptedDebts.split(',');
      final List<DebtDTO> debts = [];
      for (var encryptedValue in encryptedValues) {
        try {
          final decrypted =
              encrypter.decrypt64(encryptedValue, iv: _encryptionHelper.iv);
          final decodedJson = json.decode(decrypted);
          final debt = DebtDTO.fromJson(decodedJson);
          debts.add(debt);
        } catch (e) {
          // Handle decryption errors
        }
      }
      return debts;
    }
    return [];
  }
}
