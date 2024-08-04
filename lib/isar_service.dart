import 'dart:math';

import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:training_app_for_weekend/models/user.dart';
import 'package:training_app_for_weekend/models/user_names.dart';

class IsarService {
  IsarService() {
    db = openDB();
  }

  late Future<Isar> db;

  Future<Isar> openDB() async {
    final dir = await getApplicationDocumentsDirectory();
    if (Isar.instanceNames.isEmpty) {
      return await Isar.open(
        [UserSchema],
        directory: dir.path,
      );
    }
    return Future.value(Isar.getInstance());
  }

  Future<void> addUsers() async {
    List<User> usersList = [];
    final random = Random();
    for (int i = 0; i < 1000; i++) {
      final newUser = User()
        ..name = UserNames.values[random.nextInt(10)].userName
        ..age = Random().nextInt(100);
      usersList.add(newUser);
    }
    final isar = await db;
    isar.writeTxn(() => isar.users.putAll(usersList));
  }

  Future<List<User>> getAllUsers() async {
    List<User> usersList = [];
    final isar = await db;
    await isar.writeTxn(() async {
      usersList = await isar.users.where().findAll();
    });
    return usersList;
  }

}
