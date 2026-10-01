import 'dart:convert';
import 'dart:isolate';
import 'dart:math';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';

class PasswordHash {
  const PasswordHash({
    required this.salt,
    required this.hash,
    required this.iterations,
  });

  factory PasswordHash.fromJson(Map<String, dynamic> json) => PasswordHash(
    salt: json['salt'] as String,
    hash: json['hash'] as String,
    iterations: json['iterations'] as int,
  );

  final String salt;
  final String hash;
  final int iterations;

  Map<String, dynamic> toJson() => {
    'salt': salt,
    'hash': hash,
    'iterations': iterations,
    'algorithm': 'pbkdf2-hmac-sha256',
  };
}

/// PBKDF2-HMAC-SHA256 password hashing with a random per-account salt.
class PasswordHasher {
  const PasswordHasher({this.iterations = 120000});

  final int iterations;
  static const _keyLength = 32;

  Future<PasswordHash> hash(String password) async {
    final random = Random.secure();
    final salt = Uint8List.fromList(
      List.generate(16, (_) => random.nextInt(256)),
    );
    final derived = await _derive(password, salt, iterations);
    return PasswordHash(
      salt: base64Encode(salt),
      hash: base64Encode(derived),
      iterations: iterations,
    );
  }

  Future<bool> verify(String password, PasswordHash stored) async {
    final derived = await _derive(
      password,
      base64Decode(stored.salt),
      stored.iterations,
    );
    final expected = base64Decode(stored.hash);
    if (derived.length != expected.length) return false;
    var diff = 0;
    for (var i = 0; i < derived.length; i++) {
      diff |= derived[i] ^ expected[i];
    }
    return diff == 0;
  }

  static Future<Uint8List> _derive(
    String password,
    List<int> salt,
    int iterations,
  ) => Isolate.run(() => pbkdf2(utf8.encode(password), salt, iterations));

  static Uint8List pbkdf2(List<int> password, List<int> salt, int iterations) {
    final hmac = Hmac(sha256, password);
    final blocks = (_keyLength / 32).ceil();
    final output = BytesBuilder();
    for (var block = 1; block <= blocks; block++) {
      final blockIndex = [
        (block >> 24) & 0xff,
        (block >> 16) & 0xff,
        (block >> 8) & 0xff,
        block & 0xff,
      ];
      var u = hmac.convert([...salt, ...blockIndex]).bytes;
      final t = Uint8List.fromList(u);
      for (var i = 1; i < iterations; i++) {
        u = hmac.convert(u).bytes;
        for (var j = 0; j < t.length; j++) {
          t[j] ^= u[j];
        }
      }
      output.add(t);
    }
    return Uint8List.fromList(output.toBytes().sublist(0, _keyLength));
  }
}
