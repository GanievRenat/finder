import 'package:flinder/common/ui/main_app_builder.dart';
import 'package:flinder/common/ui/main_app_runner.dart';

void main() {
  final env = const String.fromEnvironment("env", defaultValue: "dev");
  final runner = MainAppRunner(env: env);
  final builder = MainAppBuilder();
  runner.run(builder);
}
