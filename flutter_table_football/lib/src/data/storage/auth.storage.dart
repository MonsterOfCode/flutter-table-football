import 'dart:convert';

import 'package:flutter_table_football/src/data/models/player.model.dart';
import 'package:flutter_table_football/src/data/storage/Storable.storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthStorage extends StorageService<Player> {
  static final AuthStorage _instance = AuthStorage._internal();
  SharedPreferences? _prefs;
  final String storageKey = "auth";

  // Private constructor
  AuthStorage._internal();

  // Factory constructor to return the instance of AuthStorage
  factory AuthStorage() {
    return _instance;
  }

  // Initialize SharedPreferences
  Future<void> _initPrefs() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  /// Write player authenticated to SharedPreferences
  @override
  Future<void> write(Player player) async {
    await _initPrefs();
    await _prefs!.setString(storageKey, json.encode(player.toMap()));
  }

  /// Retrieve authenticated player from SharedPreferences
  @override
  Future<Player?> read() async {
    await _initPrefs();
    String? read = _prefs!.getString(storageKey);
    if (read == null) return null;
    return Player.fromMap(json.decode(_prefs!.getString(storageKey)!));
  }

  // Clean data from SharedPreferences
  @override
  Future<void> clean() async {
    await _initPrefs();
    await _prefs!.remove(storageKey);
  }
}
