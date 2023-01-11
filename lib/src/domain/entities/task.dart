import 'package:faker/faker.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:jnote/src/utils/constants/hive_keys.dart';

part 'task.freezed.dart';
part 'task.g.dart';

@HiveType(typeId: HiveKeys.taskBoxID)
@Freezed(copyWith: true, equal: true)
class Task with _$Task {
  const factory Task(
    @HiveField(0) final int id,
    @HiveField(1) final String title,
    @HiveField(2) final String description, [
    @HiveField(3) @Default(false) final bool isCompleted,
  ]) = _Task;
}

List<Task> generateFakeTasks(int count, {bool isCompleted = false}) {
  final faker = Faker();
  return List.generate(
    count,
    (index) => Task(
      index + 1,
      faker.lorem.word(),
      faker.lorem.sentence(),
      isCompleted,
    ),
  );
}
