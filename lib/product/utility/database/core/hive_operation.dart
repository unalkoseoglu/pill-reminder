import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pill_reminder/product/utility/database/model/hive_model.dart';
part 'hive_manager_mixin.dart';

class HiveOperation<T extends HiveModelMixin> with HiveManagerMixin<T> {
  void addOrUpdateItem(T model) => _box.put(model.key, model);

  T? getItem(String key) => _box.get(key);

  Future<void> addItem(T model) async {
    await _box.add(model);
  }

  List<T>? getAllItem() => _box.values.toList();

  ValueListenable<Box<T>> listenToReminder() {
    return _box.listenable();
  }

  Future<void> deleteItem(String key) => _box.delete(key);
}
