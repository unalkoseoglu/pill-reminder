import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
part '../core/hive_manager_mixin.dart';

class HiveOperation<T> with HiveManagerMixin<T> {
  void addOrUpdateItem(dynamic key, T model) => _box.put(key, model);

  T? getItem(dynamic key) => _box.get(key);

  Future<void> addItem(dynamic key, T model) async {
    return await _box.put(key, model);
  }

  List<T>? getAllItem() => _box.values.toList();

  ValueListenable<Box<T>> listenToReminder() {
    return _box.listenable();
  }

  Future<void> deleteItem(dynamic key) => _box.delete(key);

  bool contains(dynamic key) => _box.containsKey(key);
}
