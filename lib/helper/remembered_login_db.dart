import 'package:encrypt/encrypt.dart' as enc;
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sqflite/sqflite.dart';

import '../data_model/auth/remembered_login_model.dart';

/// SQLite data source for "Remember me" credentials (passwords encrypted).
void _log(String msg) => debugPrint('[RememberMe][DB] $msg');

class RememberedLoginDb {
  RememberedLoginDb._();

  static final RememberedLoginDb instance = RememberedLoginDb._();

  static const String _table = 'remembered_logins';
  static const String _keyName = 'remembered_login_aes_key';
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  Database? _db;
  enc.Encrypter? _encrypter;

  /// AES-256-GCM key lives in the Keychain/Keystore, never in the database.
  Future<enc.Encrypter> get _crypto async {
    if (_encrypter != null) return _encrypter!;
    var encoded = await _secureStorage.read(key: _keyName);
    if (encoded == null) {
      _log('no AES key in secure storage, generating a new one');
      encoded = enc.Key.fromSecureRandom(32).base64;
      await _secureStorage.write(key: _keyName, value: encoded);
    } else {
      _log('AES key loaded from secure storage');
    }
    _encrypter = enc.Encrypter(
      enc.AES(enc.Key.fromBase64(encoded), mode: enc.AESMode.gcm),
    );
    return _encrypter!;
  }

  /// Stored as base64(iv) ':' base64(ciphertext), with a fresh IV per value.
  Future<String> _encrypt(String plain) async {
    final iv = enc.IV.fromSecureRandom(12);
    final cipher = (await _crypto).encrypt(plain, iv: iv);
    return '${iv.base64}:${cipher.base64}';
  }

  Future<String?> _decrypt(String stored) async {
    try {
      final parts = stored.split(':');
      return (await _crypto).decrypt(
        enc.Encrypted.fromBase64(parts[1]),
        iv: enc.IV.fromBase64(parts[0]),
      );
    } catch (e) {
      _log('decrypt failed: $e');
      return null;
    }
  }

  Future<Database> get _database async {
    if (_db != null) return _db!;
    final dir = await getDatabasesPath();
    _log('opening database at $dir/remembered_logins.db');
    _db = await openDatabase(
      '$dir/remembered_logins.db',
      version: 1,
      onCreate: (db, _) => db.execute(
        'CREATE TABLE $_table ('
        'username TEXT PRIMARY KEY, '
        'password TEXT NOT NULL, '
        'updated_at INTEGER NOT NULL)',
      ),
    );
    return _db!;
  }

  /// Inserts the login, or replaces the password if the username exists.
  Future<void> upsert(String username, String password) async {
    final db = await _database;
    _log('upsert username=$username');
    await db.insert(
      _table,
      {
        'username': username,
        'password': await _encrypt(password),
        'updated_at': DateTime.now().millisecondsSinceEpoch,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// Updates the password only when the username is already remembered.
  Future<void> updateIfExists(String username, String password) async {
    final db = await _database;
    _log('updateIfExists username=$username');
    final count = await db.update(
      _table,
      {
        'password': await _encrypt(password),
        'updated_at': DateTime.now().millisecondsSinceEpoch,
      },
      where: 'username = ?',
      whereArgs: [username],
    );
    _log('updateIfExists rows updated=$count');
  }

  Future<List<RememberedLogin>> getAll() async {
    final db = await _database;
    final rows = await db.query(_table, orderBy: 'updated_at DESC');
    _log('getAll rows in table=${rows.length}');
    final logins = <RememberedLogin>[];
    for (final r in rows) {
      final password = await _decrypt(r['password'] as String);
      // Undecryptable rows (e.g. key lost after reinstall) are skipped.
      if (password == null) continue;
      logins.add(RememberedLogin(
        username: r['username'] as String,
        password: password,
      ));
    }
    _log('getAll decrypted=${logins.length}');
    return logins;
  }

  Future<void> delete(String username) async {
    final db = await _database;
    _log('delete username=$username');
    await db.delete(_table, where: 'username = ?', whereArgs: [username]);
  }
}
