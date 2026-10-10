import 'package:hive_flutter/hive_flutter.dart';

class CounterStorage {
  static const String boxName = 'counterBox';
  static const String counterKey = 'counter';

  static Future<void> init() async {
    await Hive.initFlutter();

    if (!Hive.isBoxOpen(boxName)) {
      await Hive.openBox<int>(boxName);
    }
  }

  static Box<int> get _box => Hive.box<int>(boxName);

  static int getCounter() {
    return _box.get(counterKey, defaultValue: 6) ?? 6;
  }

  static Future<void> saveCounter(int value) async {
    await _box.put(counterKey, value);
  }
}