import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<void> initializeApp() async {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );
  WidgetsFlutterBinding.ensureInitialized();
}
