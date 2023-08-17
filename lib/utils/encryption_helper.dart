import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:encrypt/encrypt.dart';

class EncryptionHelper {
  final _storage = const FlutterSecureStorage();
  final _key = Key.fromUtf8('60ab3a236ba98eff6fa7769cfe52dba6');
  final _iv = IV.fromLength(16);

  Key get key => _key;
  IV get iv => _iv;
  FlutterSecureStorage get storage => _storage;
}
