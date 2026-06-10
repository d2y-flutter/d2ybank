import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';

class PinHashResult {
  final String hash;
  final String salt;
  final int iterations;

  const PinHashResult({
    required this.hash,
    required this.salt,
    required this.iterations,
  });
}

class PinHashService {
  static const int defaultIterations = 120000;
  static const int _saltLength = 32;

  PinHashResult hashPin(
    String pin, {
    int iterations = defaultIterations,
  }) {
    final salt = _generateSalt();

    final hash = _pbkdf2HmacSha256(
      password: pin,
      salt: salt,
      iterations: iterations,
      derivedKeyLength: 32,
    );

    return PinHashResult(
      hash: base64Encode(hash),
      salt: base64Encode(salt),
      iterations: iterations,
    );
  }

  bool verifyPin({
    required String pin,
    required String storedHash,
    required String storedSalt,
    required int iterations,
  }) {
    final salt = base64Decode(storedSalt);

    final hash = _pbkdf2HmacSha256(
      password: pin,
      salt: salt,
      iterations: iterations,
      derivedKeyLength: 32,
    );

    final computedHash = base64Encode(hash);

    return _constantTimeEquals(computedHash, storedHash);
  }

  List<int> _generateSalt() {
    final random = Random.secure();
    return List<int>.generate(
      _saltLength,
      (_) => random.nextInt(256),
    );
  }

  List<int> _pbkdf2HmacSha256({
    required String password,
    required List<int> salt,
    required int iterations,
    required int derivedKeyLength,
  }) {
    final passwordBytes = utf8.encode(password);
    final hmac = Hmac(sha256, passwordBytes);
    final blockCount = (derivedKeyLength / 32).ceil();

    final output = <int>[];

    for (var blockIndex = 1; blockIndex <= blockCount; blockIndex++) {
      final blockSalt = <int>[
        ...salt,
        (blockIndex >> 24) & 0xff,
        (blockIndex >> 16) & 0xff,
        (blockIndex >> 8) & 0xff,
        blockIndex & 0xff,
      ];

      var u = hmac.convert(blockSalt).bytes;
      final block = List<int>.from(u);

      for (var i = 1; i < iterations; i++) {
        u = hmac.convert(u).bytes;

        for (var j = 0; j < block.length; j++) {
          block[j] ^= u[j];
        }
      }

      output.addAll(block);
    }

    return output.take(derivedKeyLength).toList();
  }

  bool _constantTimeEquals(String a, String b) {
    final aBytes = utf8.encode(a);
    final bBytes = utf8.encode(b);

    if (aBytes.length != bBytes.length) return false;

    var diff = 0;

    for (var i = 0; i < aBytes.length; i++) {
      diff |= aBytes[i] ^ bBytes[i];
    }

    return diff == 0;
  }
}