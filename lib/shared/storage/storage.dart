import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

class StorageApp {
  static const String db = 'nasa_db';

  static Future<Box> openHiveBox(String boxName) async {
    if (!Hive.isBoxOpen(boxName))
      Hive.init((await getApplicationDocumentsDirectory()).path);

    return await Hive.openBox(boxName);
  }

  static dynamic select(String index) async {
    var box = await openHiveBox(db);

    return box.get(index);
  }

  static put(String index, Map<dynamic, dynamic> map) async {
    var box = await openHiveBox(db);
    box.put(index, map);
  }

  static delete(String index) async {
    var box = await openHiveBox(db);
    box.delete(index);
  }
}
