import 'package:injectable/injectable.dart';

@singleton
class VeniceStateService {
  String _veniceKey = '';

  String get key => _veniceKey;
  set setKey(String key) => _veniceKey = key;
}
