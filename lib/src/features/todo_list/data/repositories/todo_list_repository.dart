import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/src/core/app_constants.dart';

class TodoListRepository {
  /// Local tasks encrypted management
  Future<void> saveEncryptedTaskData({required String task}) async {
    const secureStorage = FlutterSecureStorage();
    // if key not exists return null
    final encryptionKeyString =
        await secureStorage.read(key: AppConstants.tasksBoxKey);
    if (encryptionKeyString == null) {
      final key = Hive.generateSecureKey();
      await secureStorage.write(
        key: AppConstants.tasksBoxKey,
        value: base64UrlEncode(key),
      );
    }

    final key = await secureStorage.read(key: AppConstants.tasksBoxKey);
    final encryptionKeyUint8List = base64Url.decode(key!);

    final encryptedBox = await Hive.openBox(AppConstants.tasksBoxName,
        encryptionCipher: HiveAesCipher(encryptionKeyUint8List));

    await encryptedBox.add(task);
  }

  Future<List<String>> getEncryptedTaskData() async {
    List<String> savedTask = [];
    const secureStorage = FlutterSecureStorage();

    final key = await secureStorage.read(key: AppConstants.tasksBoxKey);

    if (key != null) {
      final encryptionKeyUint8List = base64Url.decode(key);

      final encryptedBox = await Hive.openBox(AppConstants.tasksBoxName,
          encryptionCipher: HiveAesCipher(encryptionKeyUint8List));

      savedTask = List<String>.from(encryptedBox.values);
    }

    return savedTask;
  }

  Future<void> removeTaskFromHive(int index) async {
    const secureStorage = FlutterSecureStorage();

    final key = await secureStorage.read(key: AppConstants.tasksBoxKey);
    final encryptionKeyUint8List = base64Url.decode(key!);

    final encryptedBox = await Hive.openBox(AppConstants.tasksBoxName,
        encryptionCipher: HiveAesCipher(encryptionKeyUint8List));

    await encryptedBox.deleteAt(index);
  }
}
