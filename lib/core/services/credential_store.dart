import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'password_hasher.dart';

/// Sensitive local account metadata (never the plaintext password).
class StoredCredential {
  const StoredCredential({required this.userId, this.email, this.password});

  factory StoredCredential.fromJson(Map<String, dynamic> json) =>
      StoredCredential(
        userId: json['userId'] as String,
        email: json['email'] as String?,
        password: json['password'] == null
            ? null
            : PasswordHash.fromJson(json['password'] as Map<String, dynamic>),
      );

  final String userId;
  final String? email;
  final PasswordHash? password;

  bool get hasPassword => password != null;

  Map<String, dynamic> toJson() => {
    'userId': userId,
    'email': email,
    'password': password?.toJson(),
  };
}

abstract class CredentialStore {
  Future<StoredCredential?> read();
  Future<void> write(StoredCredential credential);
  Future<void> clear();
}

class SecureCredentialStore implements CredentialStore {
  SecureCredentialStore([FlutterSecureStorage? storage])
    : _storage = storage ?? const FlutterSecureStorage();

  final FlutterSecureStorage _storage;
  static const _key = 'taqaddum.credential.v1';

  @override
  Future<StoredCredential?> read() async {
    final raw = await _storage.read(key: _key);
    if (raw == null) return null;
    return StoredCredential.fromJson(jsonDecode(raw) as Map<String, dynamic>);
  }

  @override
  Future<void> write(StoredCredential credential) =>
      _storage.write(key: _key, value: jsonEncode(credential.toJson()));

  @override
  Future<void> clear() => _storage.delete(key: _key);
}

class InMemoryCredentialStore implements CredentialStore {
  StoredCredential? _value;

  @override
  Future<StoredCredential?> read() async => _value;

  @override
  Future<void> write(StoredCredential credential) async => _value = credential;

  @override
  Future<void> clear() async => _value = null;
}
