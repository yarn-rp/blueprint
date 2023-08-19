/// {@template key_pair_storage}
/// Base class class to implement new key pair storage for serialized data.
/// {@endtemplate}
abstract interface class KeyPairStorage {
  /// Reads the value associated with the given [key].
  Future<String?> read({required String key});

  /// Reads all the values.
  Future<Map<String, String>> readAll();

  /// Writes the given [value] associated with the given [key].
  Future<void> write({required String key, required String value});

  /// Deletes the value associated with the given [key].
  Future<void> delete({required String key});

  /// Deletes all the values.
  Future<void> deleteAll();
}
