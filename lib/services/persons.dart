import 'dart:convert';
import 'package:encrypt/encrypt.dart';

import 'package:wallet_kit/DTO/person_dto.dart';
import '../utils/encryption_helper.dart';

class PersonsService {
  final EncryptionHelper _encryptionHelper = EncryptionHelper();

  Future<void> saveEncryptedPerson(PersonDTO person) async {
    final jsonString = json.encode(person.toJson());
    final encrypter = Encrypter(AES(_encryptionHelper.key, mode: AESMode.cbc));
    final encrypted = encrypter.encrypt(jsonString, iv: _encryptionHelper.iv);
    var persons = await _encryptionHelper.storage.read(key: 'persons');
    if (persons == null) {
      await _encryptionHelper.storage
          .write(key: 'persons', value: encrypted.base64);
    } else {
      await _encryptionHelper.storage
          .write(key: 'persons', value: '$persons,${encrypted.base64}');
    }
  }

  Future<List<PersonDTO>> getDecryptedPersons() async {
    final encryptedPersons =
        await _encryptionHelper.storage.read(key: 'persons');
    if (encryptedPersons != null) {
      final encrypter =
          Encrypter(AES(_encryptionHelper.key, mode: AESMode.cbc));
      final encryptedValues = encryptedPersons.split(',');
      final List<PersonDTO> decryptedPersons = [];
      for (var encryptedValue in encryptedValues) {
        try {
          final decrypted =
              encrypter.decrypt64(encryptedValue, iv: _encryptionHelper.iv);
          final decodedJson = json.decode(decrypted);
          final person = PersonDTO.fromJson(decodedJson);
          decryptedPersons.add(person);
        } catch (e) {
          // Handle decryption errors
        }
      }
      return decryptedPersons;
    }
    return [];
  }

  Future<String> getPersonNameById(int id) async {
    final persons = await getDecryptedPersons();
    final person = persons.firstWhere((element) => element.id == id);
    return person.name;
  }
}
