import 'package:flutter/foundation.dart';

import 'package:hive/hive.dart';
import 'package:live_chat_app/constants/firestore_constants.dart';
import 'package:live_chat_app/hive/hive_storage.dart';
import 'package:path_provider/path_provider.dart';

class HiveStuff {
  static Future<void> init() async {
    if (!kIsWeb) {
      var path = await getTemporaryDirectory();
      Hive.init(path.path);
    }

    loggedBox = await Hive.openBox(FirestoreConstants.isAdmin);
    loggedBox = await Hive.openBox(FirestoreConstants.LOGGED);
    emailPassBox = await Hive.openBox(FirestoreConstants.EMAIL);
    emailPassBox = await Hive.openBox(FirestoreConstants.PASS);
    checkBox = await Hive.openBox(FirestoreConstants.ISCHECK);
  }
}
