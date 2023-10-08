import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// {@template flutter_secure_key_pair_storage}
/// Implementation of [KeyPairStorage] using [FlutterSecureStorage].
/// {@endtemplate}
class FlutterSecureKeyPairStorage implements KeyPairStorage {
  /// {@macro flutter_secure_key_pair_storage}
  const FlutterSecureKeyPairStorage({
    required FlutterSecureStorage flutterSecureStorage,
  }) : _flutterSecureStorage = flutterSecureStorage;

  final FlutterSecureStorage _flutterSecureStorage;

  @override
  Future<void> delete({required String key}) =>
      _flutterSecureStorage.delete(key: key);

  @override
  Future<void> deleteAll() => _flutterSecureStorage.deleteAll();

  @override
  Future<String?> read({required String key}) =>
      _flutterSecureStorage.read(key: key);

  @override
  Future<Map<String, String>> readAll() => _flutterSecureStorage.readAll();

  @override
  Future<void> write({required String key, required String value}) =>
      _flutterSecureStorage.write(key: key, value: value);
}
