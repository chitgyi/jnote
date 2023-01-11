import 'package:hive_flutter/hive_flutter.dart';
import 'package:jnote/src/domain/entities/task.dart';

void registerHiveAdapters() {
  Hive.registerAdapter(TaskAdapter());
}
