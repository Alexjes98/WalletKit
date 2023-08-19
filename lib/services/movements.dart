import 'dart:convert';
import 'package:encrypt/encrypt.dart';

import '../DTO/movement_dto.dart';
import '../utils/encryption_helper.dart';

class MovementsService {
  final EncryptionHelper _encryptionHelper = EncryptionHelper();

  Future<void> saveEncryptedMovement(MovementDTO movement) async {
    final jsonString = json.encode(movement.toJson());
    final encrypter = Encrypter(AES(_encryptionHelper.key, mode: AESMode.cbc));
    final encrypted = encrypter.encrypt(jsonString, iv: _encryptionHelper.iv);
    var movements = await _encryptionHelper.storage.read(key: 'movements');
    if (movements == null) {
      await _encryptionHelper.storage
          .write(key: 'movements', value: encrypted.base64);
    } else {
      await _encryptionHelper.storage
          .write(key: 'movements', value: '$movements,${encrypted.base64}');
    }
  }

  Future<void> deleteEncryptedMovement(int id) async {
    await _encryptionHelper.storage.delete(key: '$id');
  }

  Future<void> deleteAllEncryptedMovements() async {
    await _encryptionHelper.storage.delete(key: 'movements');
  }

  Future<MovementDTO?> getDecryptedMovement(int id) async {
    final encryptedMovements =
        await _encryptionHelper.storage.read(key: 'movements');
    if (encryptedMovements != null) {
      final encrypter =
          Encrypter(AES(_encryptionHelper.key, mode: AESMode.cbc));
      final encryptedValues = encryptedMovements.split(',');
      for (var encryptedValue in encryptedValues) {
        try {
          final decrypted =
              encrypter.decrypt64(encryptedValue, iv: _encryptionHelper.iv);
          final decodedJson = json.decode(decrypted);
          final movement = MovementDTO.fromJson(decodedJson);
          if (movement.id == id) {
            return movement;
          }
        } catch (e) {
          // Handle decryption errors
        }
      }
    }
  }

  Future<List<MovementDTO>> getAllDecryptedMovements() async {
    final encryptedMovements =
        await _encryptionHelper.storage.read(key: 'movements');
    if (encryptedMovements != null) {
      final encrypter =
          Encrypter(AES(_encryptionHelper.key, mode: AESMode.cbc));
      final encryptedValues = encryptedMovements.split(',');
      final List<MovementDTO> movements = [];
      for (var encryptedValue in encryptedValues) {
        try {
          final decrypted =
              encrypter.decrypt64(encryptedValue, iv: _encryptionHelper.iv);
          final decodedJson = json.decode(decrypted);
          final movement = MovementDTO.fromJson(decodedJson);
          movements.add(movement);
        } catch (e) {
          // Handle decryption errors
        }
      }
      return movements;
    }
    return [];    
  }
}
