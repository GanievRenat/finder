import 'package:injectable/injectable.dart';

@singleton
class DeepSeekStateService {
  String _deepSeekKey = '';

  String get key => _deepSeekKey;
  set setKey(String key) => _deepSeekKey = key;
}
