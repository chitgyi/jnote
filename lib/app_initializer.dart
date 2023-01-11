import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:jnote/src/di/locator.dart';
import 'package:jnote/src/utils/helpers/register_hive_adapters.dart';

Future<void> initializeApp() async {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );

  configureDependencies();
  await Hive.initFlutter();
  registerHiveAdapters();
}
