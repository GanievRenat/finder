// ignore: depend_on_referenced_packages
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

import 'package:flirta/common/ui/admin_app_runner.dart';
import 'package:flirta/common/ui/main_app_builder.dart';

void main() {
  usePathUrlStrategy();
  final env = const String.fromEnvironment("env", defaultValue: "dev");
  final runner = AdminAppRunner(env: env);
  final builder = MainAppBuilder();
  runner.run(builder);
}
