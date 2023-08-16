import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:encrypt/encrypt.dart';

import '../DTO/movement_dto.dart';

class EncryptionHelper {
  final _storage = const FlutterSecureStorage();
  final _key = Key.fromUtf8(''); // Replace with your own secret key
  final _iv = IV.fromLength(16); // Initialization vector for AES encryption

  Future<void> saveEncryptedMovement(MovementDTO movement) async {
    final jsonString = json.encode(movement.toJson());
    final encrypter = Encrypter(AES(_key, mode: AESMode.cbc));

    final encrypted = encrypter.encrypt(jsonString, iv: _iv);

    await _storage.write(key: '${movement.id}', value: encrypted.base64);
  }

  Future<MovementDTO?> getDecryptedMovement(int id) async {
    try {
      final encryptedValue = await _storage.read(key: '$id');
      if (encryptedValue == null) return null;

      final encrypter = Encrypter(AES(_key, mode: AESMode.cbc));
      final decrypted = encrypter.decrypt64(encryptedValue, iv: _iv);
      final decodedJson = json.decode(decrypted);

      return MovementDTO.fromJson(decodedJson);
    } catch (e) {
      return null;
    }
  }

  Future<void> deleteMovement(int id) async {
    await _storage.delete(key: '$id');
  }

  Future<void> deleteAllMovements() async {
    await _storage.deleteAll();
  }

  Future<List<MovementDTO>> getAllDecryptedMovements() async {
    List<MovementDTO> decryptedMovements = [];
    final allKeys = await _storage.readAll();
    final encrypter = Encrypter(AES(_key, mode: AESMode.cbc));
    for (var key in allKeys.keys) {
      final encryptedValue = allKeys[key];
      if (encryptedValue != null) {
        try {
          final decrypted = encrypter.decrypt64(encryptedValue, iv: _iv);
          final decodedJson = json.decode(decrypted);
          decryptedMovements.add(MovementDTO.fromJson(decodedJson));
        } catch (e) {
          // Handle decryption errors
        }
      }
    }
    decryptedMovements.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return decryptedMovements;
  }
}
