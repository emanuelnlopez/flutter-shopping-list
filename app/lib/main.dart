import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:presentation/presentation.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    debugPrint('${record.level.name}: ${record.time}: ${record.message}');
  });
  DependencyInjector().initialize(environment: Environment.mock);
  runApp(App());
}
