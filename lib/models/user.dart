import 'dart:math';

import 'package:training_app_for_weekend/models/user_names.dart';

class User {
  User({
    required this.name,
    required this.age,
  });

  String name;
  int age;

  static List<User> generateUsers(int count) {
    Random random = Random();
    return List.generate(count, (index) {
      String userName = UserNames.values[random.nextInt(10)].userName;
      int userAge = random.nextInt(100) + 1;
      return User(name: userName, age: userAge);
    });
  }
}
