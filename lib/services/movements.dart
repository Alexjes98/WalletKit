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
    await _encryptionHelper.storage
        .write(key: '${movement.id}', value: encrypted.base64);
  }

  Future<void> deleteEncryptedMovement(int id) async {
    await _encryptionHelper.storage.delete(key: '$id');
  }

  Future<void> deleteAllEncryptedMovements() async {
    await _encryptionHelper.storage.deleteAll();
  }


  Future<MovementDTO?> getDecryptedMovement(int id) async {
    try {
      final encryptedValue = await _encryptionHelper.storage.read(key: '$id');
      if (encryptedValue == null) return null;
      final encrypter =
          Encrypter(AES(_encryptionHelper.key, mode: AESMode.cbc));
      final decrypted =
          encrypter.decrypt64(encryptedValue, iv: _encryptionHelper.iv);
      final decodedJson = json.decode(decrypted);

      return MovementDTO.fromJson(decodedJson);
    } catch (e) {
      return null;
    }
  }

  Future<List<MovementDTO>> getAllDecryptedMovements() async {
    List<MovementDTO> decryptedMovements = [];
    final allKeys = await _encryptionHelper.storage.readAll();
    final encrypter = Encrypter(AES(_encryptionHelper.key, mode: AESMode.cbc));
    for (var key in allKeys.keys) {
      final encryptedValue = allKeys[key];
      if (encryptedValue != null) {
        try {
          final decrypted =
              encrypter.decrypt64(encryptedValue, iv: _encryptionHelper.iv);
          final decodedJson = json.decode(decrypted);
          decryptedMovements.add(MovementDTO.fromJson(decodedJson));
        } catch (e) {
          // Handle decryption errors
        }
      }
    }
    return decryptedMovements;
  }
}
