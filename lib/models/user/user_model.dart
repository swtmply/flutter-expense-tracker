import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 1)
class User extends HiveObject {
  @HiveField(0, defaultValue: '')
  late String name;

  @HiveField(1, defaultValue: 0)
  late double balance;

  @HiveField(2, defaultValue: 0)
  late double expenses;

  @HiveField(3, defaultValue: 0)
  late double income;
}
