import 'dart:convert';

import 'package:encrypt/encrypt.dart';

import '../DTO/movement_category_dto.dart';
import '../utils/encryption_helper.dart';

class MovementCategoryService {
  final EncryptionHelper _encryptionHelper = EncryptionHelper();

  Future<void> saveEncryptedMovementCategory(
      MovementCategoryDTO movementCategory) async {
    final jsonString = json.encode(movementCategory.toJson());
    final encrypter = Encrypter(AES(_encryptionHelper.key, mode: AESMode.cbc));
    final encrypted = encrypter.encrypt(jsonString, iv: _encryptionHelper.iv);
    var movementCategories =
        await _encryptionHelper.storage.read(key: 'movementCategories');
    if (movementCategories == null) {
      await _encryptionHelper.storage
          .write(key: 'movementCategories', value: encrypted.base64);
    } else {
      await _encryptionHelper.storage.write(
          key: 'movementCategories',
          value: '$movementCategories,${encrypted.base64}');
    }
  }

  Future<void> deleteEncryptedMovementCategory(int id) async {
    final encryptedMovementCategories =
        await _encryptionHelper.storage.read(key: 'movementCategories');
    if (encryptedMovementCategories != null) {
      final encrypter =
          Encrypter(AES(_encryptionHelper.key, mode: AESMode.cbc));
      final encryptedValues = encryptedMovementCategories.split(',');
      final List<String> newEncryptedValues = [];
      for (var encryptedValue in encryptedValues) {
        try {
          final decrypted =
              encrypter.decrypt64(encryptedValue, iv: _encryptionHelper.iv);
          final decodedJson = json.decode(decrypted);
          final movementCategory = MovementCategoryDTO.fromJson(decodedJson);
          if (movementCategory.id != id) {
            newEncryptedValues.add(encryptedValue);
          }
        } catch (e) {
          // Handle decryption errors
        }
      }
      await _encryptionHelper.storage.write(
          key: 'movementCategories', value: newEncryptedValues.join(','));
    }
  }

  Future<void> deleteAllEncryptedMovementCategories() async {
    await _encryptionHelper.storage.delete(key: 'movementCategories');
  }

  Future<MovementCategoryDTO?> getDecryptedMovementCategory(int id) async {
    final encryptedMovementCategories =
        await _encryptionHelper.storage.read(key: 'movementCategories');
    if (encryptedMovementCategories != null) {
      final encrypter =
          Encrypter(AES(_encryptionHelper.key, mode: AESMode.cbc));
      final encryptedValues = encryptedMovementCategories.split(',');
      for (var encryptedValue in encryptedValues) {
        try {
          final decrypted =
              encrypter.decrypt64(encryptedValue, iv: _encryptionHelper.iv);
          final decodedJson = json.decode(decrypted);
          final movementCategory = MovementCategoryDTO.fromJson(decodedJson);
          if (movementCategory.id == id) {
            return movementCategory;
          }
        } catch (e) {
          // Handle decryption errors
        }
      }
    }
    return null;
  }

  Future<List<MovementCategoryDTO>> getAllDecryptedMovementCategories() async {
    final encryptedMovementCategories =
        await _encryptionHelper.storage.read(key: 'movementCategories');
    if (encryptedMovementCategories != null) {
      final encrypter =
          Encrypter(AES(_encryptionHelper.key, mode: AESMode.cbc));
      final encryptedValues = encryptedMovementCategories.split(',');
      final List<MovementCategoryDTO> movementCategories = [];
      for (var encryptedValue in encryptedValues) {
        try {
          final decrypted =
              encrypter.decrypt64(encryptedValue, iv: _encryptionHelper.iv);
          final decodedJson = json.decode(decrypted);
          final movementCategory = MovementCategoryDTO.fromJson(decodedJson);
          movementCategories.add(movementCategory);
        } catch (e) {
          // Handle decryption errors
        }
      }
      return movementCategories;
    }
    return [];
  }
}
