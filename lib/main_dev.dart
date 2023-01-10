import 'package:flutter/material.dart';
import 'package:jnote/app_initializer.dart';
import 'app.dart';
import 'flavors.dart';

void main() async => {
      F.appFlavor = Flavor.dev,
      await initializeApp(),
      runApp(const App()),
    };
